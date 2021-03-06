using System;
using System.Linq;
using System.Collections.Generic;
using System.Reflection;
using GTS.Clock.Model;
using GTS.Clock.Model.Concepts;
using GTS.Clock.Model.Concepts.Operations;
using GTS.Clock.Infrastructure.Exceptions;
using GTS.Clock.Infrastructure.Utility;
using GTS.Clock.Infrastructure.NHibernateFramework;
using GTS.Clock.Model.ELE;
using GTS.Clock.Infrastructure;

namespace GTS.Clock.Business.Calculator
{
    public abstract class GeneralConceptCalculator : ObjectCalculator
    {
        #region Constants
        protected const int HourMin = 60;
        #endregion

        #region Constructors

        /// <summary>
        /// ."تنها سازنده کلاس "محاسبه گر مفهوم
        /// </summary>
        /// <param name="Person">پرسنلي که محاسبات براي او در حال انجام است</param>
        /// <param name="CategorisedRule">قانوني که مفاهيم موجود در آن در صورت نياز محاسبه خواهند شد</param>
        /// <param name="CalculateDate">تاريخ انجام محاسبات</param>
        public GeneralConceptCalculator(IEngineEnvironment engineEnvironment)
            : base(engineEnvironment)
        {

        }

        #endregion

        #region Methods

        /// <summary>
        /// .این تابع وظیفه اجراي مجدد مفهوم مشخص شده با شناسه  را برعهده دارد
        /// .در این تابع با "نامعتبر" نمودن مقدار مفهوم مظمئن می شویم که مفهوم دوباره ایجاد می شود
        /// </summary>
        /// <param name="CnpID">شناسه مفهومی که باید مجددا محاسبه شود</param>        
        public void ReCalculate(decimal IdentifierCode, DateTime CalculateDate)
        {
            this.DoConcept(IdentifierCode, CalculateDate).IsValid = false;
            this.DoConcept(IdentifierCode, CalculateDate);
        }

        /// <summary>
        /// .این تابع وظیفه اجراي مجدد مفهوم مشخص شده با شناسه  را برعهده دارد
        /// .در این تابع با "نامعتبر" نمودن مقدار مفهوم مظمئن می شویم که مفهوم دوباره ایجاد می شود
        /// </summary>
        /// <param name="CnpID">شناسه مفهوم هایی که باید مجددا محاسبه شود</param>        
        public void ReCalculate(DateTime CalculateDate, params decimal[] IdentifiersCode)
        {
            for (int i = 0; i < IdentifiersCode.Length; i++)
            {
                this.DoConcept(IdentifiersCode[i], CalculateDate).IsValid = false;
                this.DoConcept(IdentifiersCode[i], CalculateDate);
            }
        }

        /// <summary>
        /// مقدار مفهوم درخواست شده را برمی گرداند، اگر مقداری برای مفهوم وجود نداشت "تهی" برمیگرداند 
        /// </summary>
        /// <param name="IdentifierCode"></param>
        /// <param name="calculationDate"></param>
        /// <returns></returns>
        public BaseScndCnpValue GetConcept(decimal IdentifierCode, DateTime calculationDate)
        {
            SecondaryConcept ScndCnp = EngEnvironment.GetConcept(IdentifierCode);
            if (ScndCnp == null)
            {
                throw new NullReferenceException(string.Format("مفهوم {0} يافت نشد", IdentifierCode));
            }

            switch (ScndCnp.CalcSituationType)
            {
                case ScndCnpCalcSituationType.BeginOfPeriode:
                    {
                        DateRange dateRange = this.Person.GetPeriodicScndCnpRange(ScndCnp, calculationDate);
                        if (dateRange.FromDate != this.ConceptCalculateDate)
                            return BaseScndCnpValue.GetScndCnpValueFacorty(ScndCnp);
                        break;
                    }
                case ScndCnpCalcSituationType.EndOfPeriode:
                    {
                        DateRange dateRange = this.Person.GetPeriodicScndCnpRange(ScndCnp, calculationDate);
                        if (dateRange.ToDate != this.ConceptCalculateDate)
                            return BaseScndCnpValue.GetScndCnpValueFacorty(ScndCnp);
                        break;
                    }
                case ScndCnpCalcSituationType.EveryDay:
                    break;
            }

            BaseScndCnpValue result = null;
            string Index = this.GenerateIndex(ScndCnp, calculationDate);

            if (!this.CalcDateZone.IsContain(calculationDate))
            {
                result = this.Person.GetFromPersistedScndCnpValues(Index);
            }
            else
            {
                result = this.Person.GetFromNotPersistedScndCnpValues(Index);
            }
            if (result == null)
                result = BaseScndCnpValue.GetScndCnpValueFacorty(ScndCnp);
            return result;
        }

        /// <summary>
        /// وظیفه آماده سازی پارامترها برای فراخوانی تابع اجرای قانون را برعهده دارد        
        /// </summary>
        /// <param name="CnpID">شناسه مفهوم قابل اجرا</param>
        /// <returns>مقدار مفهوم پس از اجرا يا بازيابي</returns>
        protected BaseScndCnpValue DoConcept(decimal IdentifierCode)
        {
            return DoConcept(IdentifierCode, this.ConceptCalculateDate);
        }

        /// <summary>
        /// .اجراي مفهوم درخواست شده را برعهده دارد
        /// در صورتيکه مقداري براي اين مفهوم موجود باشد تنها همان مقدار را برمي گرداند
        /// </summary>
        /// <param name="IdentifierCode"></param>
        /// <param name="calculationDate"></param>
        /// <returns></returns>
        public BaseScndCnpValue DoConcept(decimal IdentifierCode, DateTime calculationDate)
        {
            SecondaryConcept ScndCnp = EngEnvironment.GetConcept(IdentifierCode);

            if (ScndCnp == null)
            {
                throw new NullReferenceException(string.Format("مفهوم {0} يافت نشد", IdentifierCode));
            }

            //شرایط اجرای مفهوم به منظور بالا بردن سرعت محاساب ایجاد شده است
            //بدین ترتیب به عنوان مثال مفاهیم ماهانه برای تمام روزهای محاسبات اجرا نگردیده
            //و تنها در ابتدا یا انتهای بازه محساباتی خود اجرا می شوند
            switch (ScndCnp.CalcSituationType)
            {
                case ScndCnpCalcSituationType.BeginOfPeriode:
                    {
                        DateRange dateRange = this.Person.GetPeriodicScndCnpRange(ScndCnp, calculationDate);
                        if (dateRange.FromDate != calculationDate && !(this.Person.CalcDateZone.FromDate == calculationDate))
                            return BaseScndCnpValue.GetScndCnpValueFacorty(ScndCnp);
                        break;
                    }
                case ScndCnpCalcSituationType.EndOfPeriode:
                    {
                        DateRange dateRange = this.Person.GetPeriodicScndCnpRange(ScndCnp, calculationDate);
                        if (dateRange.ToDate != calculationDate
                            && !(this.Person.CalcDateZone.ToDate == calculationDate)
                            && !(this.Person.AssignedRuleList.Where(x => x.ToDate == calculationDate).Count() > 0))
                            return BaseScndCnpValue.GetScndCnpValueFacorty(ScndCnp);
                        break;
                    }
                case ScndCnpCalcSituationType.EveryDay:
                    break;
            }


            BaseScndCnpValue ScndCnpvalue = null;

            string Index = this.GenerateIndex(ScndCnp, calculationDate);
            bool persisted = false;
            if (!this.CalcDateZone.IsContain(calculationDate))
            {
                persisted = true;
                ScndCnpvalue = this.Person.GetFromPersistedScndCnpValues(Index);
            }
            else
            {
                persisted = false;
                ScndCnpvalue = this.Person.GetFromNotPersistedScndCnpValues(Index);
            }       

            //مفاهیم مقدار ماهانه برای تمام طول محاسبه به ازای هر روز یکبار محاسبه می گردند
            if (ScndCnpvalue == null || ScndCnpvalue.IsValid == false || (ScndCnpvalue.Concept.PeriodicType == ScndCnpPeriodicType.Periodic && ScndCnpvalue.CalculationDate != this.ConceptCalculateDate))
            {
                this.ConceptCalculateDate = calculationDate;
                //اگر مقدار مفهوم وجود ندارد باید به طور کامل ایجاد شود
                if (ScndCnpvalue == null)
                {
                    ScndCnpvalue = BaseScndCnpValue.GetScndCnpValueFacorty(ScndCnp);
                    ScndCnpvalue.Concept = ScndCnp;
                    ScndCnpvalue.Person = this.Person;
                    ScndCnpvalue.Index = this.GenerateIndex(ScndCnp, calculationDate);
                }
                ScndCnpvalue.FromDate = this.ConceptCalculateDate;
                ScndCnpvalue.ToDate = this.ConceptCalculateDate;
                ScndCnpvalue.FromPairs = "0";
                ScndCnpvalue.ToPairs = "0";
                ScndCnpvalue.CalculationDate = this.ConceptCalculateDate;
                ScndCnpvalue.IsValid = true;
                this.Person.ScndCnpValueList.Add(ScndCnpvalue.Index, ScndCnpvalue);
                //اگر مربوط به خارج رینج است چه لزومی به محاسبه است
                //البته منظور گذشته است و در مورد آیند بررسی نشده است
                //1392-04-01
                if (!persisted)
                {
                    this.ExecuteScndCnp(ScndCnpvalue.Concept, ScndCnpvalue);
                }
                return ScndCnpvalue;
            }
            //اضافه کردن در اینجا به معنی به روزرسانی نیز می باشد
            this.Person.ScndCnpValueList.Add(ScndCnpvalue.Index, ScndCnpvalue);
            return ScndCnpvalue;
        }

        /// <summary>
        /// فراخواني متد مفهوم ارسال شده و بازگشت نتيجه ي اجراي اين متد
        /// </summary>
        /// <param name="ScndCnp">مفهومي که بايد متد آن اجرا شود</param>
        /// <param name="result">مقدار فعلي مفهوم</param>
        /// <returns></returns>
        protected void ExecuteScndCnp(SecondaryConcept ScndCnp, BaseScndCnpValue Result)
        {
            try
            {
                base.GetType().InvokeMember(GetMethodName(ScndCnp.IdentifierCode), BindingFlags.InvokeMethod, null, this, new Object[] { Result, ScndCnp }, null);
            }
            catch (MissingMethodException ex)
            {
                throw new BaseException(String.Format("تابع {0} معرف مفهوم {1} موجود نيست", GetMethodName(ScndCnp.IdentifierCode), ScndCnp.Name),
                                         String.Format("ConceptCalculator.ExecuteScndCnp({0}.{1})", ScndCnp.Name, GetMethodName(ScndCnp.IdentifierCode)),
                                         ex);
            }
            catch (TargetInvocationException ex)
            {
                throw new BaseException(String.Format("خطا در اجراي مفهوم {0} در تاریخ {1} میلادی {2}", GetMethodName(ScndCnp.IdentifierCode), new PersianDateTime(this.ConceptCalculateDate).PersianDate, this.ConceptCalculateDate.ToShortDateString()),
                                         String.Format("ConceptCalculator.ExecuteScndCnp({0}.{1})", ScndCnp.Name, GetMethodName(ScndCnp.IdentifierCode)),
                                         ex);
            }
            catch (Exception ex)
            {
                throw new BaseException(String.Format("خطا در اجراي مفهوم {0} در تاریخ {1} میلادی {2}", GetMethodName(ScndCnp.IdentifierCode), new PersianDateTime(this.ConceptCalculateDate).PersianDate, this.ConceptCalculateDate.ToShortDateString()),
                                         String.Format("ConceptCalculator.ExecuteScndCnp({0}.{1})", ScndCnp.Name, GetMethodName(ScndCnp.IdentifierCode)),
                                         ex);
            }
        }

        /// <summary>
        /// وظیفه ایجاد "شناسه" با توجه به پارامتر های ورودی برای بازیابی مقدار مفهوم برعهده این تابع است
        /// </summary>
        /// <param name="scndCnp">شناسه مفهومی که مقدار آن مدنظر است</param>
        /// <param name="Date">تاریخی که مقدار مفهوم در آن مدنظر است</param>
        protected string GenerateIndex(SecondaryConcept ScndCnp, DateTime _calculationDate)
        {
            string Index = "";
            if (ScndCnp.PeriodicType == ScndCnpPeriodicType.NoPeriodic)
            {
                Index = BaseScndCnpValue.GetIndex(this.Person.ID, ScndCnp.ID, _calculationDate);
            }
            else
            {
                DateRange dateRange = this.Person.GetPeriodicScndCnpRange(ScndCnp, _calculationDate);
                Index = BaseScndCnpValue.GetIndex(this.Person.ID, ScndCnp.ID, dateRange);
            }
            return Index;
        }

        /// <summary>
        /// براساس "شناسه" ورودی نام متد مابه ازای آن را برمی گرداند
        /// </summary>
        /// <param name="IdentifierCode"></param>
        /// <returns></returns>
        protected string GetMethodName(decimal IdentifierCode)
        {
            return String.Format("C{0}", IdentifierCode);
        }

        #endregion

        #region Defined Method

        #region مفاهيم کارکرد

        /// <summary>مفهوم حضور</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي يک-1 درنظر گرفته شده است</remarks>
        public virtual void C1(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ProceedTraffic ProceedTraffic = this.Person.GetProceedTraficByDate(this.ConceptCalculateDate);
            if (ProceedTraffic != null && ProceedTraffic.HasHourlyItem)
            {
                foreach (ProceedTrafficPair pair in ProceedTraffic.Pairs)
                {
                    if ((pair.IsFilled) && (pair.PishcardCode == 0 || pair.PishcardCode == 10 || pair.PishcardCode == 7 || pair.PishcardCode == 28 || pair.PishcardCode == 3))
                    {
                        PairableScndCnpValue.AppendPairToScndCnpValue(pair, Result);
                    }
                }
            }
        }

        /// <summary>کارکردخالص ساعتي</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي دو-2 درنظر گرفته شده است</remarks>
        public virtual void C2(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PairableScndCnpValue unionResult = (PairableScndCnpValue)this.DoConcept(1);
            ((PairableScndCnpValue)Result).AddPairs(Operation.Intersect(unionResult,
                                                         this.Person.GetShiftByDate(this.ConceptCalculateDate)).Pairs);
            ((PairableScndCnpValue)Result).AppendPairs(Operation.Intersect(this.DoConcept(2030),
                                                        this.Person.GetShiftByDate(this.ConceptCalculateDate)).Pairs);

            if (this.Person.GetShiftByDate(this.ConceptCalculateDate).ShiftType == ShiftTypesEnum.OVERTIME)
            {
                ((PairableScndCnpValue)this.DoConcept(4002)).AddPairs(((PairableScndCnpValue)this.DoConcept(1)).Pairs);
                this.DoConcept(2).Value = 0;
                this.DoConcept(4).Value = 0;
                this.DoConcept(6).Value = 0;
            }
        }

        /// <summary>مفهوم کارکردناخالص ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي سيزده-13 درنظر گرفته شده است</remarks>
        public virtual void C3(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;

            //Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, true, EngEnvironment.GetPrecard(Precards.OrderedOverTime));
            //Result.Value += permit.PairValues;
        }

        /// <summary>مفهوم کارکردخالص روزانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي چهار-4 درنظر گرفته شده است</remarks>
        public virtual void C4(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم کارکردخالص روزانه ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي یکصدوسی-5 درنظر گرفته شده است</remarks>
        public virtual void C5(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم کارکردلازم</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي شش-6 درنظر گرفته شده است</remarks>
        public virtual void C6(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            try
            {
                Result.Value = this.Person.GetShiftByDate(this.ConceptCalculateDate).PairValues;
            }
            catch
            {

            }
        }
  
        /// <summary>مفهوم کارکرددرروز</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي هفت-7 درنظر گرفته شده است</remarks>
        public virtual void C7(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم کارکردخالص ساعتي ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي هفتادوشش-8 درنظر گرفته شده است</remarks>
        public virtual void C8(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>حضورماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي هفتادوهشت-9 درنظر گرفته شده است</remarks>
        public virtual void C9(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم کارکردلازم ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي شش-6 درنظر گرفته شده است</remarks>
        public virtual void C10(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم تعداد روز</summary>
        /// <param name="Result"></param>     
        public virtual void C11(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = (this.CalcDateZone.ToDate - this.CalcDateZone.FromDate).Days;
        }

        /// <summary>مفهوم حضور جمعه</summary>
        /// <param name="Result"></param>     
        public virtual void C12(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            if (this.ConceptCalculateDate.DayOfWeek == DayOfWeek.Friday)
            {
                ((PairableScndCnpValue)Result).AddPairs(((PairableScndCnpValue)this.DoConcept(1)).Pairs);
            }
        }
    
        /// <summary>مفهوم کارکردناخالص</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي سيزده-13 درنظر گرفته شده است</remarks>
        public virtual void C13(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(2).Value + this.DoConcept(4002).Value + this.DoConcept(4017).Value;            
        }

        /// <summary>مفهوم شب</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي چهارده-14 درنظر گرفته شده است</remarks>
        public virtual void C14(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم کارکرد خالص شب</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي پانزده-15 درنظر گرفته شده است</remarks>
        public virtual void C15(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            var hh = Operation.Intersect(this.DoConcept(1), this.DoConcept(14));

            ((PairableScndCnpValue)Result).AddPairs(hh.Pairs);
        }

        /// <summary>مفهوم شب کاري</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي شانزده-16 درنظر گرفته شده است</remarks>
        public virtual void C16(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم کارکردخالص تعطيل</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي هفده-17 درنظر گرفته شده است</remarks>
        public virtual void C17(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم کارکرد واقعی</summary>
        /// <param name="Result"></param>     
        public virtual void C18(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ((PairableScndCnpValue)Result).AddPairs(Operation.Intersect(this.DoConcept(1),
                                                     this.Person.GetShiftByDate(this.ConceptCalculateDate)).Pairs);
        }

        /// <summary>مفهوم کارکردخالص ساعتي سالانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي نوزده-19 درنظر گرفته شده است</remarks>
        public virtual void C19(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم حضور تعطیلات خاص</summary>
        /// <param name="Result"></param>     
        public virtual void C20(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }
    
        /// <summary>مفهوم حضورویژه</summary>
        /// <param name="Result"></param>     
        public virtual void C21(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {       
            Result.Value = 0;
        }

        /// <summary>مفهوم حضور تعطیلات خاص ماهانه</summary>
        /// <param name="Result"></param>     
        public virtual void C22(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم تعطیلات جزو کارکرد حساب شود</summary>
        /// <param name="Result"></param>     
        public virtual void C23(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم تعطیلات رسمی جزو کارکرد حساب شود</summary>
        /// <param name="Result"></param>     
        public virtual void C24(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم روزهای غیر کاری جزو کارکرد حساب شود</summary>
        /// <param name="Result"></param>     
        public virtual void C25(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

    
        #endregion

        #region مفاهيم مرخصي

        /// <summary>مفهوم مرخصي درروز</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي بيست-1001 درنظر گرفته شده است</remarks>
        public virtual void C1001(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم مرخصي استحقاقي خالص ساعتي</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي بيست و يک-21 درنظر گرفته شده است</remarks>
        public virtual void C1002(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {

            ((PairableScndCnpValue)Result).ClearPairs();
            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourLeave1));

            PairableScndCnpValue PermitInShift = new PairableScndCnpValue();

            int demandLeave = 0;
            int leavePieceCount = this.DoConcept(1092).Value;           

            #region محاسبه مجوزهای داخل شیفتی که محدودیت های تعداد و مقدار برای آنها اعمال شده باشد
            
            BaseShift shift = this.Person.GetShiftByDate(this.ConceptCalculateDate);
            foreach (PermitPair permitPair in permit.Pairs)
            {
                PairableScndCnpValue pairsInShift = Operation.Intersect(permitPair, shift);

                #region سقف ها
                //سقف مقدار مرخصی ساعتی در ماه
                if (this.DoConcept(1084).Value != 0 &&
                              this.DoConcept(1011).Value + PermitInShift.Value + pairsInShift.Value > this.DoConcept(1084).Value)
                {
                    continue;
                }
               
                //سقف تعداد مرخصی ساعتی در ماه
                if (this.DoConcept(1083).Value != 0 &&
                       leavePieceCount + 1 > this.DoConcept(1083).Value)
                {
                    continue;
                }
                else
                {
                    leavePieceCount += 1;
                } 
                #endregion

                PermitInShift.AppendPairs(pairsInShift.Pairs);
            }

            #endregion

            #region بررسی مقدار طلب بمنظور تبدیل مجوز مرخصی به مرخصی

            demandLeave = this.Person.GetRemainLeave(this.ConceptCalculateDate);
            if (PermitInShift.Value > 0 && PermitInShift.Value > demandLeave)
            {
                PairableScndCnpValue removedPairs = PermitInShift.DecreasePairFromLast(PermitInShift.Value - demandLeave);
                //تبدیل مرخصی استحقاقی به مرخصی بی حقوق در صورت عدم طلب
                if (this.DoConcept(1014).Value == 1)
                {
                    ((PairableScndCnpValue)this.DoConcept(3028)).AddPairs(Operation.Differance(this.DoConcept(3028), removedPairs));
                    ((PairableScndCnpValue)this.DoConcept(3001)).AddPairs(Operation.Differance(this.DoConcept(3001), removedPairs));

                    this.DoConcept(1056).Value += removedPairs.PairValues;
                }
            }

            #endregion

            if (PermitInShift.Value > 0)
            {
                ((PairableScndCnpValue)Result).AppendPairs(Operation.Intersect(this.DoConcept(3028), PermitInShift));
                this.Person.AddUsedLeave(this.ConceptCalculateDate,
                                         Operation.Intersect(this.DoConcept(3028), PermitInShift).Value, permit);
                ((PairableScndCnpValue)this.DoConcept(3028)).AddPairs(Operation.Differance(this.DoConcept(3028), PermitInShift));
                ((PairableScndCnpValue)this.DoConcept(3001)).AddPairs(Operation.Differance(this.DoConcept(3001), PermitInShift));
                this.DoConcept(1092).Value = leavePieceCount;

                this.ReCalculate(this.ConceptCalculateDate, 3008, 3010, 3014, 3029, 3030, 3031);
            }
        }

        /// <summary>مفهوم مرخصي استحقاقي ساعتي</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي بيست و سه-1003 درنظر گرفته شده است</remarks>
        public virtual void C1003(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ((PairableScndCnpValue)Result).AddPairs(this.DoConcept(1002));
        }

        /// <summary>مفهوم مرخصي استحقاقي خالص روزانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي بيست و دو-22 درنظر گرفته شده است</remarks>
        public virtual void C1004(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            //طبق توافق صورت گرفته در اینجا تنها داشتن مجوز ملاک مقداردهی مرخصی استحقاقی روزانه است
            int leaveInDay = this.DoConcept(1001).Value > this.DoConcept(6).Value
                                 ? this.DoConcept(6).Value
                                 : this.DoConcept(1001).Value;

            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.DailyEstehghaghiLeave));
            if (permit != null && permit.Value == 1)
            {
                if (this.Person.GetShiftByDate(this.ConceptCalculateDate).Value > 0)
                {
                    int demandLeave = this.Person.GetRemainLeave(this.ConceptCalculateDate);
                    if (leaveInDay > demandLeave)
                    {
                        //تبدیل مرخصی استحقاقی به مرخصی بی حقوق در صورت عدم طلب
                        if (this.DoConcept(1014).Value == 1)
                        {
                            this.DoConcept(1066).Value = 1;
                        }
                    }
                    else
                    {
                        Result.Value = 1;
                        this.Person.AddUsedLeave(this.ConceptCalculateDate, leaveInDay, permit);
                    }
                }
                else
                {
                    //مرخصی قطعی در روزغیرکاری
                    if (this.DoConcept(1021).Value == 1)
                    {
                        //حتی اگر طلب نداشته باشد باید منفی شود                        
                        Result.Value = 1;
                        this.Person.AddUsedLeave(this.ConceptCalculateDate, leaveInDay, permit);
                    }
                }
            }
        }
 
        /// <summary>مفهوم مرخصي استحقاقي روزانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي بيست و چهار-1005 درنظر گرفته شده است</remarks>
        public virtual void C1005(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(1004).Value;
        }

        /// <summary>مفهوم مرخصي استحقاقي روزانه ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي بيست و پنج-1006 درنظر گرفته شده است</remarks>
        public virtual void C1006(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم مرخصي استعلاجي خالص ساعتي</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي بيست و شش-26 درنظر گرفته شده است</remarks>
        public virtual void C1007(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            bool maxState = true;

            if (this.DoConcept(1020).Value == 1)
            {
                PairableScndCnpValue absent = (PairableScndCnpValue)this.DoConcept(3028);
                if (absent != null && absent.PairCount > 0)
                {
                    Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourLeave2));
                    PairableScndCnpValue validLeave = Operation.Intersect(permit, absent);
                   
                    if (validLeave.Value > 0 && maxState)
                    {
                        ((PairableScndCnpValue)Result).AppendPairs(validLeave);
                        absent.Value -= validLeave.Value;
                        ((PairableScndCnpValue)this.DoConcept(3001)).DecreasePairFromLast(validLeave.Value);
                        ((PairableScndCnpValue)this.DoConcept(3028)).DecreasePairFromLast(validLeave.Value);
                    }
                    else
                    {
                        if (this.DoConcept(1015).Value == 1)
                        {
                            this.DoConcept(1056).Value = validLeave.Value;
                            ((PairableScndCnpValue)this.DoConcept(3001)).DecreasePairFromLast(validLeave.Value);
                            ((PairableScndCnpValue)this.DoConcept(3028)).DecreasePairFromLast(validLeave.Value);
                        }
                    }
                }
            }
        }

        /// <summary>مفهوم مرخصی استعلاجی ساعتی</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه این مفهوم در تعاریف بعدی صد و سیزده-1008 درنظر گرفته شده است</remarks>
        public virtual void C1008(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ((PairableScndCnpValue)Result).AppendPairs(this.DoConcept(1007));
        }

        /// <summary>مفهوم مرخصی استعلاجی خالص روزانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه این مفهوم در تعاریف بعدی صد و یازده-1009 درنظر گرفته شده است</remarks>
        public virtual void C1009(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            //1021 مرخصی قطعی در روزغیرکاری
            //1017  مرخصی استعلاجی روزانه ماه
            //1018  مرخصی استعلاجی روزانه سالانه
            //1086 سقف مرخصی روزانه استعلاجی در ماه
            //1087 سقف مرخصی روزانه استعلاجی در سال
            Result.Value = 0;

            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.DailyEstelagiLeave));
            if (permit != null && permit.Value == 1)
            {
                if (this.DoConcept(1021).Value > 0
                    || this.Person.GetShiftByDate(this.ConceptCalculateDate).Value > 0)
                {
                    //سقف مرخصی استعلاجی سالانه
                    if (this.DoConcept(1086).Value != 0 &&
                        this.DoConcept(1017).Value + 1 > this.DoConcept(1086).Value)
                    {
                        return;
                    }    

                    //سقف مرخصی استعلاجی سالانه
                    if (this.DoConcept(1087).Value != 0 &&
                        this.DoConcept(1018).Value + 1 > this.DoConcept(1087).Value)
                    {
                        return;
                    }                   

                    Result.Value = 1;
                }
            }
        }

        /// <summary>مفهوم مرخصی استعلاجی روزانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه این مفهوم در تعاریف بعدی صد و ذوازده-1010 درنظر گرفته شده است</remarks>
        public virtual void C1010(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(1009).Value;
        }
        
        /// <summary>مفهوم مرخصي استحقاقي ساعتي ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي بيست و هفت-1011 درنظر گرفته شده است</remarks>
        public virtual void C1011(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم مرخصي استحقاقي ساعتي سالانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي بيست و هشت-28 درنظر گرفته شده است</remarks>
        public virtual void C1012(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم مرخصي استحقاقي روزانه سالانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي بيست و هشت-1012 درنظر گرفته شده است</remarks>
        public virtual void C1013(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم مرخصی بی حقوق در صورت عدم طلب مرخصی استحقاقی</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه این مفهوم در تعاریف بعدی صد و یک-101 درنظر گرفته شده است</remarks>
        public virtual void C1014(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم مرخصی بی حقوق در صورت عدم طلب مرخصی استعلاجی</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه این مفهوم در تعاریف بعدی صد و دو-1015 درنظر گرفته شده است</remarks>
        public virtual void C1015(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }
 
        /// <summary>مفهوم مرخصی استعلاجی ساعتی ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه این مفهوم در تعاریف بعدی صد و سیزده-113 درنظر گرفته شده است</remarks>
        public virtual void C1016(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم مرخصی استعلاجی روزانه ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه این مفهوم در تعاریف بعدی صد و ذوازده-112 درنظر گرفته شده است</remarks>
        public virtual void C1017(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم مرخصی استعلاجی روزانه سالانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي چهل و يک-41 درنظر گرفته شده است</remarks>
        public virtual void C1018(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم مرخصی استعلاجی ساعتی سالانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي چهل و يک-41 درنظر گرفته شده است</remarks>
        public virtual void C1019(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم مرخصی باید با مجوز باشد </summary>
        /// <param name="Result"></param>
        public virtual void C1020(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;

        }   

        /// <summary>مفهوم مرخصی قطعی در روزغیرکاری </summary>
        /// <param name="Result"></param>
        public virtual void C1021(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {

            Result.Value = 0;
        }

        /// <summary>مفهوم مرخصی بی حقوق بیماری قطعی در روزغیرکاری </summary>
        /// <param name="Result"></param>
        public virtual void C1022(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }
  
        /// <summary>مفهوم مرخصي با حقوق خالص ساعتی_23</summary>
        /// <param name="Result"></param>
        public virtual void C1023(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {

            ProceedTraffic ProceedTraffic = this.Person.GetProceedTraficByDate(this.ConceptCalculateDate);
            BaseShift shift = this.Person.GetShiftByDate(this.ConceptCalculateDate);
            if (ProceedTraffic != null && ProceedTraffic.HasHourlyItem)
            {
                foreach (ProceedTrafficPair pair in ProceedTraffic.Pairs)
                {
                    if (pair.IsFilled && (pair.PishcardCode == 23 || pair.PishcardCode == 43))
                    {
                        PairableScndCnpValue validLeave;
                        if (this.DoConcept(1020).Value == 1)
                        {
                            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourLeave3));
                            validLeave = Operation.Intersect(shift, Operation.Intersect(pair, permit));
                        }
                        else
                        {
                            validLeave = Operation.Intersect(shift, pair);
                        }
                        //PairableScndCnpValue validLeave = Operation.Intersect(shift, Operation.Intersect(permit.FilterByPrecard(1003), pair));
                        if (validLeave.Value > 0)
                        {
                            ((PairableScndCnpValue)Result).AppendPairs(validLeave);
                        }
                        else
                        {
                            this.DoConcept(3001).Value += Operation.Intersect(shift, pair).Value;
                            this.DoConcept(3028).Value += Operation.Intersect(shift, pair).Value;
                        }
                    }
                }
            }


            if (this.DoConcept(1020).Value == 1)
            {
                PairableScndCnpValue absent = (PairableScndCnpValue)this.DoConcept(3028);
                if (absent != null && absent.PairCount > 0)
                {
                    Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourLeave3));
                    PairableScndCnpValue validLeave = Operation.Intersect(permit, absent);
                    if (validLeave.Value > 0)
                    {
                        ((PairableScndCnpValue)Result).AppendPairs(validLeave);
                        absent.Value -= validLeave.Value;
                        this.DoConcept(3028).Value -= validLeave.Value;
                        if (this.DoConcept(3028).Value < 0)
                        {
                            this.DoConcept(3028).Value = 0;
                        }
                    }
                }
            }

        }

        /// <summary>مفهوم مرخصي با حقوق خالص ساعتی_24</summary>
        /// <param name="Result"></param>
        public virtual void C1024(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {

            ProceedTraffic ProceedTraffic = this.Person.GetProceedTraficByDate(this.ConceptCalculateDate);
            BaseShift shift = this.Person.GetShiftByDate(this.ConceptCalculateDate);
            if (ProceedTraffic != null && ProceedTraffic.HasHourlyItem)
            {
                foreach (ProceedTrafficPair pair in ProceedTraffic.Pairs)
                {
                    if (pair.IsFilled && (pair.PishcardCode == 24 || pair.PishcardCode == 44))
                    {
                        PairableScndCnpValue validLeave;
                        if (this.DoConcept(1020).Value == 1)
                        {
                            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourLeave4));
                            validLeave = Operation.Intersect(shift, Operation.Intersect(pair, permit));
                        }
                        else
                        {
                            validLeave = Operation.Intersect(shift, pair);
                        }
                        //PairableScndCnpValue validLeave = Operation.Intersect(shift, Operation.Intersect(permit.FilterByPrecard(1005), pair));
                        if (validLeave.Value > 0)
                        {
                            ((PairableScndCnpValue)Result).AppendPairs(validLeave);
                        }
                        else
                        {
                            this.DoConcept(3001).Value += Operation.Intersect(shift, pair).Value;
                            this.DoConcept(3028).Value += Operation.Intersect(shift, pair).Value;
                        }
                    }
                }
            }
            if (this.DoConcept(1020).Value == 1)
            {
                PairableScndCnpValue absent = (PairableScndCnpValue)this.DoConcept(3028);
                if (absent != null && absent.PairCount > 0)
                {
                    Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourLeave4));
                    PairableScndCnpValue validLeave = Operation.Intersect(permit, absent);
                    if (validLeave.Value > 0)
                    {
                        ((PairableScndCnpValue)Result).AppendPairs(validLeave);
                        absent.Value -= validLeave.Value;
                        this.DoConcept(3028).Value -= validLeave.Value;
                        if (this.DoConcept(3028).Value < 0)
                        {
                            this.DoConcept(3028).Value = 0;
                        }
                    }
                }
            }

        }

        /// <summary>مفهوم مرخصي با حقوق خالص ساعتی -25</summary>
        /// <param name="Result"></param>
        public virtual void C1025(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {

            ProceedTraffic ProceedTraffic = this.Person.GetProceedTraficByDate(this.ConceptCalculateDate);
            BaseShift shift = this.Person.GetShiftByDate(this.ConceptCalculateDate);
            if (ProceedTraffic != null && ProceedTraffic.HasHourlyItem)
            {
                foreach (ProceedTrafficPair pair in ProceedTraffic.Pairs)
                {
                    if (pair.IsFilled && (pair.PishcardCode == 25 || pair.PishcardCode == 45))
                    {
                        PairableScndCnpValue validLeave;
                        if (this.DoConcept(1020).Value == 1)
                        {
                            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourLeave4));
                            validLeave = Operation.Intersect(shift, Operation.Intersect(pair, permit));
                        }
                        else
                        {
                            validLeave = Operation.Intersect(shift, pair);
                        }
                        //PairableScndCnpValue validLeave = Operation.Intersect(shift, Operation.Intersect(permit.FilterByPrecard(1007), pair));
                        if (validLeave.Value > 0)
                        {
                            ((PairableScndCnpValue)Result).AppendPairs(validLeave);
                        }
                        else
                        {
                            this.DoConcept(3001).Value += Operation.Intersect(shift, pair).Value;
                            this.DoConcept(3028).Value += Operation.Intersect(shift, pair).Value;
                        }
                    }
                }
            }
            if (this.DoConcept(1020).Value == 1)
            {
                PairableScndCnpValue absent = (PairableScndCnpValue)this.DoConcept(3028);
                if (absent != null && absent.PairCount > 0)
                {
                    Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourLeave6));
                    PairableScndCnpValue validLeave = Operation.Intersect(permit, absent);
                    if (validLeave.Value > 0)
                    {
                        ((PairableScndCnpValue)Result).AppendPairs(validLeave);
                        absent.Value -= validLeave.Value;
                        this.DoConcept(3028).Value -= validLeave.Value;
                        if (this.DoConcept(3028).Value < 0)
                        {
                            this.DoConcept(3028).Value = 0;
                        }
                    }
                }
            }

        }

        /// <summary>مفهوم مرخصي با حقوق خالص ساعتی -26</summary>
        /// <param name="Result"></param>
        public virtual void C1026(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {

            ProceedTraffic ProceedTraffic = this.Person.GetProceedTraficByDate(this.ConceptCalculateDate);
            BaseShift shift = this.Person.GetShiftByDate(this.ConceptCalculateDate);
            if (ProceedTraffic != null && ProceedTraffic.HasHourlyItem)
            {
                foreach (ProceedTrafficPair pair in ProceedTraffic.Pairs)
                {
                    if (pair.IsFilled && (pair.PishcardCode == 26 || pair.PishcardCode == 46))
                    {
                        PairableScndCnpValue validLeave;
                        if (this.DoConcept(1020).Value == 1)
                        {
                            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourLeave4));
                            validLeave = Operation.Intersect(shift, Operation.Intersect(pair, permit));
                        }
                        else
                        {
                            validLeave = Operation.Intersect(shift, pair);
                        }
                        //PairableScndCnpValue validLeave = Operation.Intersect(shift, Operation.Intersect(permit.FilterByPrecard(1007), pair));
                        if (validLeave.Value > 0)
                        {
                            ((PairableScndCnpValue)Result).AppendPairs(validLeave);
                        }
                        else
                        {
                            this.DoConcept(3001).Value += Operation.Intersect(shift, pair).Value;
                            this.DoConcept(3028).Value += Operation.Intersect(shift, pair).Value;
                        }
                    }
                }
            }
            if (this.DoConcept(1020).Value == 1)
            {
                PairableScndCnpValue absent = (PairableScndCnpValue)this.DoConcept(3028);
                if (absent != null && absent.PairCount > 0)
                {
                    Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourLeave6));
                    PairableScndCnpValue validLeave = Operation.Intersect(permit, absent);
                    if (validLeave.Value > 0)
                    {
                        ((PairableScndCnpValue)Result).AppendPairs(validLeave);
                        absent.Value -= validLeave.Value;
                        this.DoConcept(3028).Value -= validLeave.Value;
                        if (this.DoConcept(3028).Value < 0)
                        {
                            this.DoConcept(3028).Value = 0;
                        }
                    }
                }
            }

        }

        /// <summary>مفهوم مرخصي با حقوق خالص ساعتی -27</summary>
        /// <param name="Result"></param>
        public virtual void C1027(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {

            ProceedTraffic ProceedTraffic = this.Person.GetProceedTraficByDate(this.ConceptCalculateDate);
            BaseShift shift = this.Person.GetShiftByDate(this.ConceptCalculateDate);
            if (ProceedTraffic != null && ProceedTraffic.HasHourlyItem)
            {
                foreach (ProceedTrafficPair pair in ProceedTraffic.Pairs)
                {
                    if (pair.IsFilled && (pair.PishcardCode == 27 || pair.PishcardCode == 47))
                    {
                        PairableScndCnpValue validLeave;
                        if (this.DoConcept(1020).Value == 1)
                        {
                            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourLeave4));
                            validLeave = Operation.Intersect(shift, Operation.Intersect(pair, permit));
                        }
                        else
                        {
                            validLeave = Operation.Intersect(shift, pair);
                        }
                        //PairableScndCnpValue validLeave = Operation.Intersect(shift, Operation.Intersect(permit.FilterByPrecard(1007), pair));
                        if (validLeave.Value > 0)
                        {
                            ((PairableScndCnpValue)Result).AppendPairs(validLeave);
                        }
                        else
                        {
                            this.DoConcept(3001).Value += Operation.Intersect(shift, pair).Value;
                            this.DoConcept(3028).Value += Operation.Intersect(shift, pair).Value;
                        }
                    }
                }
            }
            if (this.DoConcept(1020).Value == 1)
            {
                PairableScndCnpValue absent = (PairableScndCnpValue)this.DoConcept(3028);
                if (absent != null && absent.PairCount > 0)
                {
                    Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourLeave6));
                    PairableScndCnpValue validLeave = Operation.Intersect(permit, absent);
                    if (validLeave.Value > 0)
                    {
                        ((PairableScndCnpValue)Result).AppendPairs(validLeave);
                        absent.Value -= validLeave.Value;
                        this.DoConcept(3028).Value -= validLeave.Value;
                        if (this.DoConcept(3028).Value < 0)
                        {
                            this.DoConcept(3028).Value = 0;
                        }
                    }
                }
            }

        }

        /// <summary>مفهوم مرخصي با حقوق خالص روزانه_44</summary>
        /// <param name="Result"></param>
        public virtual void C1028(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.DailyLeave2));
            Result.Value = permit != null && permit.Value == 1 ? 1 : 0;
        }

        /// <summary>مفهوم مرخصی با حقوق روزانه_44 </summary>
        /// <param name="Result"></param>
        public virtual void C1029(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(1028).Value;
        }

        /// <summary>مفهوم مرخصي با حقوق خالص روزانه_43</summary>
        /// <param name="Result"></param>
        public virtual void C1030(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.DailyLeave1));
            Result.Value = permit != null && permit.Value == 1 ? 1 : 0;
        }

        /// <summary>مفهوم مرخصی با حقوق روزانه_43 </summary>
        /// <param name="Result"></param>
        public virtual void C1031(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(1030).Value;
        }

        /// <summary>مفهوم مرخصي با حقوق خالص روزانه_46</summary>
        /// <param name="Result"></param>
        public virtual void C1032(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.DailyLeave4));
            Result.Value = permit != null && permit.Value == 1 ? 1 : 0;
        }

        /// <summary>مفهوم مرخصی با حقوق روزانه_46 </summary>
        /// <param name="Result"></param>
        public virtual void C1033(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(1032).Value;
        }

        /// <summary>مفهوم مرخصي با حقوق خالص روزانه_47</summary>
        /// <param name="Result"></param>
        public virtual void C1034(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.DailyLeave5));
            Result.Value = permit != null && permit.Value == 1 ? 1 : 0;
        }

        /// <summary>مفهوم مرخصی با حقوق روزانه_47 </summary>
        /// <param name="Result"></param>
        public virtual void C1035(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(1034).Value;
        }

        /// <summary>مفهوم مرخصي با حقوق خالص روزانه-45</summary>
        /// <param name="Result"></param>
        public virtual void C1036(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.DailyLeave3));
            Result.Value = permit != null && permit.Value == 1 ? 1 : 0;
        }

        /// <summary>مفهوم مرخصی با حقوق روزانه-45 </summary>
        /// <param name="Result"></param>
        public virtual void C1037(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(1036).Value;
        }   

        /// <summary>مرخصي ساعتي با حقوق_23 </summary>
        /// <param name="Result"></param>
        public virtual void C1038(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(1023).Value;
        }

        /// <summary>مرخصي ساعتي با حقوق_24 </summary>
        /// <param name="Result"></param>
        public virtual void C1039(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(1024).Value;
        }

        /// <summary>مرخصي ساعتي با حقوق_25 </summary>
        /// <param name="Result"></param>
        public virtual void C1040(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(1025).Value;
        }

        /// <summary>مرخصي ساعتي با حقوق_26</summary>
        /// <param name="Result"></param>
        public virtual void C1041(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(1026).Value;
        }

        /// <summary>مرخصي ساعتي با حقوق_27</summary>
        /// <param name="Result"></param>
        public virtual void C1042(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(1027).Value;
        }

        /// <summary>مفهوم مرخصي باحقوق ساعتي ماهانه_23</summary>
        /// <param name="Result"></param>        
        public virtual void C1043(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم مرخصي باحقوق ساعتي ماهانه_24</summary>
        /// <param name="Result"></param>        
        public virtual void C1044(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم مرخصي باحقوق ساعتي ماهانه_25</summary>
        /// <param name="Result"></param>        
        public virtual void C1045(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم مرخصي باحقوق ساعتي ماهانه_26</summary>
        /// <param name="Result"></param>        
        public virtual void C1046(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم مرخصي باحقوق ساعتي ماهانه_27</summary>
        /// <param name="Result"></param>        
        public virtual void C1047(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم مرخصي باحقوق روزانه ماهانه-43</summary>
        /// <param name="Result"></param>        
        /// <param name="Result"></param>
        public virtual void C1048(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم مرخصي باحقوق روزانه ماهانه-44</summary>
        /// <param name="Result"></param>        
        /// <param name="Result"></param>
        public virtual void C1049(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم مرخصي باحقوق روزانه ماهانه-45</summary>
        /// <param name="Result"></param>        
        /// <param name="Result"></param>
        public virtual void C1050(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم مرخصي باحقوق روزانه ماهانه-3009</summary>
        /// <param name="Result"></param>        
        /// <param name="Result"></param>
        public virtual void C1051(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم مرخصي باحقوق روزانه ماهانه-47</summary>
        /// <param name="Result"></param>        
        /// <param name="Result"></param>
        public virtual void C1052(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم مرخصی بیماری بی حقوق خالص ساعتی_11 </summary>
        /// <param name="Result"></param>
        public virtual void C1053(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            if (this.DoConcept(1020).Value == 1)
            {
                Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.NoSallaryIllnessHourLeave));
                if (permit == null || permit.PairCount == 0)
                {
                    return;
                }
                PairableScndCnpValue absent = (PairableScndCnpValue)this.DoConcept(3028);
                if (absent != null && absent.PairCount > 0)
                {
                    if (permit == null)
                    {
                        permit = new Permit();
                    }

                    PairableScndCnpValue validLeave =
                        Operation.Intersect(
                            Operation.Union(permit.FilterByPrecard(15)), absent);

                    if (validLeave.Value > 0)
                    {
                        ((PairableScndCnpValue)Result).AppendPairs(validLeave);
                        absent.AddPairs(Operation.Differance(absent, validLeave));
                    }
                }
            }
        }

        /// <summary>مفهوم مرخصی بیماری بی حقوق ساعتی_11 </summary>
        /// <param name="Result"></param>
        public virtual void C1054(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(1053).Value;
        }

        /// <summary>مفهوم مرخصی بی حقوق خالص ساعتی_12 </summary>
        /// <param name="Result"></param>
        public virtual void C1055(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            #region comment
            //#if FALAT
            //            ProceedTraffic ProceedTraffic = this.Person.GetProceedTraficWithDate(this.ConceptCalculateDate);
            //            BaseShift shift = this.Person.GetShiftWithDate(this.ConceptCalculateDate);
            //            if (ProceedTraffic != null && ProceedTraffic.HasHourlyItem)
            //            {
            //                foreach (ProceedTrafficPair pair in ProceedTraffic.Pairs)
            //                {
            //                    if (pair.IsFilled && (pair.PishcardCode == 12 || pair.PishcardCode == 32))
            //                    {
            //                        PairableScndCnpValue validLeave;

            //                        validLeave = Operation.Intersect(shift, pair);

            //                        if (validLeave.Value > 0)
            //                        {
            //                            ((PairableScndCnpValue)Result).AppendPairs(validLeave);
            //                            this.DoConcept(1093).Value += 1;
            //                        }
            //                        else
            //                        {
            //                            this.DoConcept(3001).Value += Operation.Intersect(shift, pair).Value;
            //                            this.DoConcept(3028).Value += Operation.Intersect(shift, pair).Value;
            //                        }
            //                    }
            //                }
            //            }
            //#else
            #endregion

            ((PairableScndCnpValue)Result).ClearPairs();

            PairableScndCnpValue TrafficdLeave = new PairableScndCnpValue();
            PairableScndCnpValue AbsentLeave = new PairableScndCnpValue();

            #region واکشی ترددهای مرخصی
            ProceedTraffic ProceedTraffic = this.Person.GetProceedTraficByDate(this.ConceptCalculateDate);
            BaseShift shift = this.Person.GetShiftByDate(this.ConceptCalculateDate);
            if (ProceedTraffic != null && ProceedTraffic.HasHourlyItem)
            {
                foreach (ProceedTrafficPair pair in ProceedTraffic.Pairs)
                {
                    if (pair.IsFilled && pair.PishcardCode == 12)
                    {
                        PairableScndCnpValue pairInShift = Operation.Intersect(shift, pair);
                        TrafficdLeave.AppendPairs(pairInShift);
                    }
                }
            }
            #endregion

            #region واکشی غیبت ها
            PairableScndCnpValue absent = (PairableScndCnpValue)this.DoConcept(3028);
            AbsentLeave.AppendPairs(absent);
            #endregion

            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.NoSallaryHourLeave1));

            #region تبدیل ترددهای مرخصی به غیبت در صورت عدم مجوز
            if (TrafficdLeave.Value > 0)
            {
                ((PairableScndCnpValue)this.DoConcept(3028)).AppendPairs(Operation.Differance(TrafficdLeave, permit));
                ((PairableScndCnpValue)this.DoConcept(3001)).AppendPairs(Operation.Differance(TrafficdLeave, permit));
            }
            #endregion

            TrafficdLeave.AddPairs(Operation.Intersect(permit, TrafficdLeave));
            AbsentLeave.AddPairs(Operation.Intersect(permit, AbsentLeave));

            #region افزودن تردد های مرخصی به حقوق مجوز دار به نتیجه
            if (TrafficdLeave.Value > 0)
            {
                ((PairableScndCnpValue)Result).AddPairs(TrafficdLeave);
            }
            #endregion

            #region افزودن غیبت های مجوز دار به نتیجه
            if (AbsentLeave.Value > 0)
            {
                ((PairableScndCnpValue)Result).AppendPairs(AbsentLeave);
                ((PairableScndCnpValue)this.DoConcept(3028)).AddPairs(Operation.Differance(this.DoConcept(3028), AbsentLeave));
                ((PairableScndCnpValue)this.DoConcept(3001)).AddPairs(Operation.Differance(this.DoConcept(3001), AbsentLeave));
            }

            #endregion

            this.ReCalculate(this.ConceptCalculateDate, 3008, 3010, 3014, 3029, 3030, 3031);
        }

        /// <summary>مفهوم مرخصی بی حقوق  ساعتی_12</summary>
        /// <param name="Result"></param>
        public virtual void C1056(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(1055).Value;
        }

        /// <summary>مفهوم مرخصی بیماری بی حقوق خالص ساعتی_13 </summary>
        /// <param name="Result"></param>
        public virtual void C1057(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.NoSallaryIllnessHourLeave));
            Result.Value = permit != null && permit.Value == 1 ? 1 : 0;
        }

        /// <summary>مفهوم مرخصی بیماری بی حقوق ساعتی_13 </summary>
        /// <param name="Result"></param>
        public virtual void C1058(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(1057).Value;
        }

        /// <summary>مفهوم  </summary>
        /// <param name="Result"></param>
        public virtual void C1059(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {

            ProceedTraffic ProceedTraffic = this.Person.GetProceedTraficByDate(this.ConceptCalculateDate);
            BaseShift shift = this.Person.GetShiftByDate(this.ConceptCalculateDate);
            if (ProceedTraffic != null && ProceedTraffic.HasHourlyItem)
            {
                foreach (ProceedTrafficPair pair in ProceedTraffic.Pairs)
                {
                    if (pair.IsFilled && (pair.PishcardCode == 14 || pair.PishcardCode == 34))
                    {
                        PairableScndCnpValue validLeave;
                        if (this.DoConcept(1020).Value == 1)
                        {
                            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.NoSallaryHourLeave1));
                            validLeave = Operation.Intersect(shift, Operation.Intersect(pair, permit));
                        }
                        else
                        {
                            validLeave = Operation.Intersect(shift, pair);
                        }
                        if (validLeave.Value > 0)
                        {
                            ((PairableScndCnpValue)Result).AppendPairs(validLeave);
                        }
                        else
                        {
                            this.DoConcept(3001).Value += Operation.Intersect(shift, pair).Value;
                            this.DoConcept(3028).Value += Operation.Intersect(shift, pair).Value;
                        }
                    }
                }
            }

            if (this.DoConcept(1020).Value == 1)
            {
                Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.NoSallaryHourLeave1));
                if (permit == null || permit.PairCount == 0)
                {
                    return;
                }
                PairableScndCnpValue absent = (PairableScndCnpValue)this.DoConcept(3028);
                if (absent != null && absent.PairCount > 0)
                {

                    if (permit == null)
                    {
                        permit = new Permit();
                    }

                    PairableScndCnpValue validLeave = Operation.Intersect(Operation.Union(permit.FilterByPrecard(14)), absent);
                    if (validLeave.Value > 0)
                    {
                        ((PairableScndCnpValue)Result).AppendPairs(validLeave);
                        absent.AddPairs(Operation.Differance(absent, validLeave));
                    }
                }
            }
        }

        /// <summary>مفهوم مرخصی بی حقوق  ساعتی_14</summary>
        /// <param name="Result"></param>
        public virtual void C1060(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(1059).Value;
        }

        /// <summary>مفهوم مرخصی بی حقوق خالص ساعتی_15 </summary>
        /// <param name="Result"></param>
        public virtual void C1061(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            if (this.DoConcept(1020).Value == 1)
            {
                Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.NoSallaryHourLeave1));
                if (permit == null || permit.PairCount == 0)
                {
                    return;
                }
                PairableScndCnpValue absent = (PairableScndCnpValue)this.DoConcept(3028);
                if (absent != null && absent.PairCount > 0)
                {
                    if (permit == null)
                    {
                        permit = new Permit();
                    }

                    PairableScndCnpValue validLeave = 
                        Operation.Intersect(Operation.Union(permit.FilterByPrecard(15)), absent);
                  
                    if (validLeave.Value > 0)
                    {
                        ((PairableScndCnpValue)Result).AppendPairs(validLeave);
                        absent.AddPairs(Operation.Differance(absent, validLeave));
                    }
                }
            }
        }

        /// <summary>مفهوم مرخصی بی حقوق  ساعتی_15</summary>
        /// <param name="Result"></param>
        public virtual void C1062(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(1061).Value;
        }

        /// <summary>مفهوم مرخصی بیماری بی حقوق خالص روزانه_31 </summary>
        /// <param name="Result"></param>
        public virtual void C1063(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.DailyNoSallaryIllnessLeave1));
            if (permit != null && permit.Value == 1)
            {
                Result.Value = 1;
                Result.FromDate =
                Result.ToDate = this.ConceptCalculateDate;
            }
            else
            {
                Result.Value = 0;
            }
        }

        /// <summary>مفهوم مرخصی بیماری بی حقوق روزانه_31 </summary>
        /// <param name="Result"></param>
        public virtual void C1064(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(1063).Value;
        }

        /// <summary>مفهوم مرخصی بی حقوق خالص روزانه_32 </summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه این مفهوم در تعاریف بعدی صد و شش-106 درنظر گرفته شده است</remarks>
        public virtual void C1065(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.DailyNoSallaryLeave1));
            if (permit != null && permit.Value == 1)
            {
                if (this.Person.GetShiftByDate(this.ConceptCalculateDate).Value > 0)
                {
                    Result.Value = 1;
                }
            }
        }

        /// <summary>مفهوم مرخصی بی حقوق روزانه_32</summary>
        /// <param name="Result"></param>
        public virtual void C1066(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(1065).Value;
        }

        /// <summary>مفهوم مرخصی بیماری بی حقوق خالص روزانه_33 </summary>
        /// <param name="Result"></param>
        public virtual void C1067(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.DailyNoSallaryLeave2));
            Result.Value = permit != null && permit.Value == 1 ? 1 : 0;
        }

        /// <summary>مفهوم مرخصی بیماری بی حقوق روزانه_33 </summary>
        /// <param name="Result"></param>
        public virtual void C1068(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(1067).Value;
        }

        /// <summary>مفهوم مرخصی بی حقوق خالص روزانه_34 </summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه این مفهوم در تعاریف بعدی صد و شش-106 درنظر گرفته شده است</remarks>
        public virtual void C1069(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.DailyNoSallaryLeave3));
            Result.Value = permit != null && permit.Value == 1 ? 1 : 0;
        }

        /// <summary>مفهوم مرخصی بی حقوق روزانه_34</summary>
        /// <param name="Result"></param>
        public virtual void C1070(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(1069).Value;
        }

        /// <summary>مفهوم مرخصی بی حقوق خالص روزانه_35 </summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه این مفهوم در تعاریف بعدی صد و شش-106 درنظر گرفته شده است</remarks>
        public virtual void C1071(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.DailyNoSallaryLeave4));
            Result.Value = permit != null && permit.Value == 1 ? 1 : 0;
        }

        /// <summary>مفهوم مرخصی بی حقوق روزانه_35</summary>
        /// <param name="Result"></param>
        public virtual void C1072(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(1071).Value;
        }

        /// <summary>مفهوم مرخصی بی حقوق ساعتی ماهانه_11</summary>        
        /// <param name="Result"></param>
        public virtual void C1073(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم مرخصی بی حقوق روزانه ماهانه_31</summary>        
        /// <param name="Result"></param>
        public virtual void C1074(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم مرخصی بی حقوق ساعتی ماهانه</summary>        
        /// <param name="Result"></param>
        public virtual void C1075(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            //برای 12و13و14و15
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم مرخصی بی حقوق روزانه ماهانه</summary>
        /// <param name="Result"></param>
        public virtual void C1076(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {//برای 32و33و34و35
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم مرخصی استحقاقی اول وقت</summary>
        /// <param name="Result"></param>
        public virtual void C1078(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ((PairableScndCnpValue)Result).ClearPairs();
            if (this.Person.GetShiftByDate(this.ConceptCalculateDate).PairCount > 0)
            {
                IPair shiftPair = this.Person.GetShiftByDate(this.ConceptCalculateDate).Pairs.OrderBy(x => x.From).First();
                foreach (IPair pair in ((PairableScndCnpValue)this.DoConcept(1003)).Pairs)
                {
                    if (pair.From == shiftPair.From)
                    {
                        ((PairableScndCnpValue)Result).AddPair(pair);
                        this.DoConcept(1079).Value = 1;
                        break;
                    }
                }
            }
        }

        /// <summary>مفهوم تعداد مرخصی استحقاقی اول وقت در روز</summary>
        /// <param name="Result"></param>
        public virtual void C1079(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم تعداد مرخصی استحقاقی اول وقت در ماه</summary>
        /// <param name="Result"></param>
        public virtual void C1080(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم مرخصی خالص استحقاقی خارج از شیفت</summary>
        /// <param name="Result"></param>
        public virtual void C1081(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ((PairableScndCnpValue)Result).ClearPairs();
            int demandLeave = 0;

            ProceedTraffic ProceedTraffic = this.Person.GetProceedTraficByDate(this.ConceptCalculateDate);
            BaseShift shift = this.Person.GetShiftByDate(this.ConceptCalculateDate);
            if (ProceedTraffic != null && ProceedTraffic.HasHourlyItem)
            {
                foreach (ProceedTrafficPair pair in ProceedTraffic.Pairs)
                {
                    demandLeave = this.Person.GetRemainLeave(this.ConceptCalculateDate);

                    if (pair.IsFilled && (pair.PishcardCode == 21 || pair.PishcardCode == 41))
                    {
                        PairableScndCnpValue validLeave;
                        if (this.DoConcept(1020).Value == 1)
                        {
                            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourLeave1));
                            validLeave = Operation.Differance(Operation.Intersect(pair, permit), shift);
                        }
                        else
                        {
                            validLeave = Operation.Differance((IPair)pair, shift);
                        }
                        if (validLeave.Value > 0)
                        {
                            if (validLeave.Value <= demandLeave)
                            {
                                ((PairableScndCnpValue)Result).AppendPairs(validLeave);
                            }
                            else if (demandLeave > 0)
                            {
                                validLeave.Value = demandLeave;
                            }
                        }
                    }
                }
            }

            if (this.DoConcept(1020).Value == 1)
            {
                Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourLeave1));
                PairableScndCnpValue validLeave = new PairableScndCnpValue();
                if (shift.Value == 0)
                {
                    PairableScndCnpValue presentOutOfShift = Operation.Differance((PairableScndCnpValue)this.DoConcept(1), shift);
                    validLeave = Operation.Differance(permit.FilterByPrecard(1002), presentOutOfShift);
                }
                else
                {
                    //PairableScndCnpValue presentOutOfShift = Operation.Differance((PairableScndCnpValue)this.DoConcept(1), shift);
                    validLeave = Operation.Differance(permit.FilterByPrecard(1002), shift);
                }

                if (validLeave.Value > 0)
                {
                    ((PairableScndCnpValue)Result).AppendPairs(validLeave);
                }
            }
        }

        /// <summary>مفهوم مجموع انواع مرخصی ساعتی که حقوق تعلق میگیرد</summary>
        /// <param name="Result"></param>
        public virtual void C1082(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
            Result.Value += this.DoConcept(1003).Value;
            Result.Value += this.DoConcept(1008).Value;
            Result.Value += this.DoConcept(1038).Value;
            Result.Value += this.DoConcept(1039).Value;
            Result.Value += this.DoConcept(1040).Value;
            Result.Value += this.DoConcept(1041).Value;
            Result.Value += this.DoConcept(1042).Value;
        }

        /// <summary>مفهوم حداکثر تعداد مرخصی ساعتی در ماه</summary>
        /// <param name="Result"></param>
        public virtual void C1083(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم حداکثر مقدار مرخصی ساعتی در ماه</summary>
        /// <param name="Result"></param>
        public virtual void C1084(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم حداکثر مقدار مرخصی ساعتی در سال</summary>
        /// <param name="Result"></param>
        public virtual void C1085(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم حداکثر مقدار مرخصی ساعتی استعلاجی در ماه</summary>
        /// <param name="Result"></param>
        public virtual void C1086(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم سقف مرخصی روزانه استعلاجی در سال</summary>
        /// <param name="Result"></param>
        public virtual void C1087(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم مرخصی به کارکرد خالص اضافه شود</summary>
        /// <param name="Result"></param>
        public virtual void C1088(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم مرخصی ساعتی باید با مجوز باشد</summary>
        /// <param name="Result"></param>        
        public virtual void C1089(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم مجموع انواع مرخصی روزانه که به آنها حقوق تعلق میگیرد        
        /// </summary>
        /// <param name="Result"></param>        
        public virtual void C1090(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            //انواع مرخصی که به آنها حقوق تعلق میگیرد
            Result.Value = 0;
            Result.Value += this.DoConcept(1005).Value;
            Result.Value += this.DoConcept(1010).Value;
            Result.Value += this.DoConcept(1029).Value;
            Result.Value += this.DoConcept(1031).Value;
            Result.Value += this.DoConcept(1033).Value;
            Result.Value += this.DoConcept(1035).Value;
            Result.Value += this.DoConcept(1037).Value;
        }

        /// <summary>مفهوم مجموع انواع مرخصی روزانه که به آنها حقوق تعلق نمیگیرد        
        /// </summary>
        /// <param name="Result"></param>        
        public virtual void C1091(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            //انواع مرخصی که به آنها حقوق تعلق نمیگیرد
            Result.Value = 0;
            Result.Value += this.DoConcept(1066).Value;
            Result.Value += this.DoConcept(1068).Value;
            Result.Value += this.DoConcept(1070).Value;
            Result.Value += this.DoConcept(1072).Value;
        }

        /// <summary>مفهوم تعداد بازه های ماهانه مرخصی ساعتی</summary>
        /// <param name="Result"></param> 
        public virtual void C1092(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم تعداد بازه های مرخصی ساعتی</summary>
        /// <param name="Result"></param> 
        public virtual void C1093(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم اگر مرخصی ماهانه از حد بخشش گذشت شامل بخشش نشود</summary>
        /// <param name="Result"></param> 
        public virtual void C1094(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم انواع مرخصی روزانه شامل با حقوق و بی حقوق </summary>
        /// <param name="Result"></param> 
        public virtual void C1095(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
            Result.Value += this.DoConcept(1005).Value;
            Result.Value += this.DoConcept(1010).Value;
            Result.Value += this.DoConcept(1029).Value;
            Result.Value += this.DoConcept(1031).Value;
            Result.Value += this.DoConcept(1033).Value;
            Result.Value += this.DoConcept(1035).Value;
            Result.Value += this.DoConcept(1037).Value;

            Result.Value += this.DoConcept(1064).Value;
            Result.Value += this.DoConcept(1066).Value;
            Result.Value += this.DoConcept(1068).Value;
            Result.Value += this.DoConcept(1070).Value;
            Result.Value += this.DoConcept(1072).Value;
        }

        /// <summaryمفهوم مجموع مرخصی باحقوق روزانه </summary>
        /// <param name="Result"></param> 
        public virtual void C1096(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
            Result.Value += this.DoConcept(1029).Value;
            Result.Value += this.DoConcept(1031).Value;
            Result.Value += this.DoConcept(1033).Value;
            Result.Value += this.DoConcept(1035).Value;
            Result.Value += this.DoConcept(1037).Value;
        }

        /// <summary>مفهوم مجموع مرخصی باحقوق روزانه  ,ماهانه </summary>
        /// <param name="Result"></param> 
        public virtual void C1097(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        #endregion

        #region مفاهيم ماموريت

        /// <summary>مفهوم ماموريت درروز</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي سي-2001 درنظر گرفته شده است</remarks>
        public virtual void C2001(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {

            Result.Value = 0;
        }

        /// <summary>مفهوم ماموريت خالص ساعتي</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي سي و يک-31 درنظر گرفته شده است</remarks>
        public virtual void C2002(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ((PairableScndCnpValue)Result).Pairs.Clear();
            PairableScndCnpValue validMission = new PairableScndCnpValue();
            PairableScndCnpValue AbsentMission = new PairableScndCnpValue();
            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourDuty1));
            BaseShift shift = this.Person.GetShiftByDate(this.ConceptCalculateDate);

            if (shift != null && shift.PairCount > 0)
            {

                #region بررسی غیبت ها

                AbsentMission.AddPairs(Operation.Intersect(permit, this.DoConcept(3028)));

                ((PairableScndCnpValue)this.DoConcept(3028)).AddPairs(Operation.Differance(this.DoConcept(3028), AbsentMission));
                ((PairableScndCnpValue)this.DoConcept(3001)).AddPairs(Operation.Differance(this.DoConcept(3001), AbsentMission));
                ((PairableScndCnpValue)Result).AppendPairs(AbsentMission);

                #endregion

                #region ماموریت در ساعات غیر کاری
                //ماموریت در ساعات غیرکاری مجاز است
                if (this.DoConcept(2029).Value == 1)
                {
                    validMission = Operation.Differance(permit, shift);
                    ((PairableScndCnpValue)Result).AppendPairs(validMission);
                }

                #endregion
            }
            else//روز تعطیل 
            {
                ((PairableScndCnpValue)Result).AppendPairs(permit.Pairs);
            }

            this.ReCalculate(this.ConceptCalculateDate, 3008, 3010, 3014, 3029, 3030, 3031);
        }

        /// <summary>مفهوم ماموريت خالص روزانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي سي و دو-32 درنظر گرفته شده است</remarks>
        public virtual void C2003(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.DailyDuty1));
            if (permit != null && permit.Value == 1)
            {
                Result.Value = 1;
            }

            /*
            ProceedTraffic ProceedTraffic = this.Person.GetProceedTraficByDate(this.ConceptCalculateDate);
            if (ProceedTraffic != null && ProceedTraffic.HasDailyItem)
            {
                foreach (ProceedTrafficPair pair in ProceedTraffic.Pairs)
                {
                    if (pair.IsFilled && pair.PishcardCode == 61)
                    {
                        Result.Value = 1;
                        //this.DoConcept(2501).Value = 1;
                        //Result.FromDate = ProceedTraffic.FromDate;
                        //Result.ToDate = ProceedTraffic.ToDate;
                    }
                }
            }
            else
            {
                //if there is not traffic for this date
                Result.Value = 0;
            }
             */
        }

        /// <summary>مفهوم ماموريت ساعتي</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي سي و سه-33 درنظر گرفته شده است</remarks>
        public virtual void C2004(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PairableScndCnpValue.AddPairsToScndCnpValue(this.DoConcept(2002), Result);
        }

        /// <summary>مفهوم مجموع ماموريت روزانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي سي و چهار-4 درنظر گرفته شده است</remarks>
        public virtual void C2005(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
            Result.Value = this.DoConcept(2031).Value;
            Result.Value += this.DoConcept(2032).Value;
            Result.Value += this.DoConcept(2033).Value;
            Result.Value += this.DoConcept(2034).Value;
            Result.Value += this.DoConcept(2035).Value;
        }

        /// <summary>مفهوم ماموريت روزانه ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي سي و پنج-2006 درنظر گرفته شده است</remarks>
        public virtual void C2006(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم ماموريت ساعتي ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي هشتادودو-2007 درنظر گرفته شده است</remarks>
        public virtual void C2007(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم مجموع ماموريت شبانه روزی</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي هشتادوسه-2008 درنظر گرفته شده است</remarks>
        public virtual void C2008(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PairableScndCnpValue.AddPairsToScndCnpValue(this.DoConcept(2041), Result);
            PairableScndCnpValue.AppendPairsToScndCnpValue(this.DoConcept(2042), Result);
            PairableScndCnpValue.AppendPairsToScndCnpValue(this.DoConcept(2043), Result);
            PairableScndCnpValue.AppendPairsToScndCnpValue(this.DoConcept(2044), Result);
            PairableScndCnpValue.AppendPairsToScndCnpValue(this.DoConcept(2045), Result);
        }

        /// <summary>مفهوم ماموريت شبانه روزی سالانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي هشتادوچهار-2009 درنظر گرفته شده است</remarks>
        public virtual void C2009(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم ماموريت روزانه سالانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي هشتادو پنج-2010 درنظر گرفته شده است</remarks>
        public virtual void C2010(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم سقف تعداد ماموریت روزانه و شبانه روزی در سال</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي هشتادو شش-2011 درنظر گرفته شده است</remarks>
        public virtual void C2011(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {

            Result.Value = 0;
        }

        /// <summary>مفهوم ماموریت در زمان استراحت بین وقت مجاز است</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي هشتاد و هفت-2012 درنظر گرفته شده است</remarks>
        public virtual void C2012(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم ماموریت دراستراحت بین وقت</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي هشتادو نه-2013 درنظر گرفته شده است</remarks>
        public virtual void C2013(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ((PairableScndCnpValue)Result).AddPairs(Operation.Intersect(this.DoConcept(5002), this.DoConcept(2004)).Pairs);
            ((PairableScndCnpValue)Result).AppendPairs(Operation.Intersect(this.DoConcept(5002), this.DoConcept(2019)).Pairs);
            ((PairableScndCnpValue)Result).AppendPairs(Operation.Intersect(this.DoConcept(5002), this.DoConcept(2020)).Pairs);
            ((PairableScndCnpValue)Result).AppendPairs(Operation.Intersect(this.DoConcept(5002), this.DoConcept(2021)).Pairs);
            ((PairableScndCnpValue)Result).AppendPairs(Operation.Intersect(this.DoConcept(5002), this.DoConcept(2022)).Pairs);
        }

        /// <summary>مفهوم ماموریت خالص ساعتی 52</summary>
        /// <param name="Result"></param>        
        public virtual void C2014(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ((PairableScndCnpValue)Result).Pairs.Clear();
            PairableScndCnpValue validMission = new PairableScndCnpValue();
            PairableScndCnpValue AbsentMission = new PairableScndCnpValue();
            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourDuty2));
            BaseShift shift = this.Person.GetShiftByDate(this.ConceptCalculateDate);

            if (shift != null && shift.PairCount > 0)
            {

                #region بررسی غیبت ها

                AbsentMission.AddPairs(Operation.Intersect(permit, this.DoConcept(3028)));

                ((PairableScndCnpValue)this.DoConcept(3028)).AddPairs(Operation.Differance(this.DoConcept(3028), AbsentMission));
                ((PairableScndCnpValue)this.DoConcept(3001)).AddPairs(Operation.Differance(this.DoConcept(3001), AbsentMission));
                ((PairableScndCnpValue)Result).AppendPairs(AbsentMission);

                #endregion

                #region ماموریت در ساعات غیر کاری
                //ماموریت در ساعات غیرکاری مجاز است
                if (this.DoConcept(2029).Value == 1)
                {
                    validMission = Operation.Differance(permit, shift);
                    ((PairableScndCnpValue)Result).AppendPairs(validMission);
                }

                #endregion
            }
            else//روز تعطیل 
            {
                ((PairableScndCnpValue)Result).AppendPairs(permit.Pairs);
            }

            this.ReCalculate(this.ConceptCalculateDate, 3008, 3010, 3014, 3029, 3030, 3031);
        }

        /// <summary>مفهوم ماموریت خالص روزانه 62</summary>
        /// <param name="Result"></param>        
        public virtual void C2015(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ProceedTraffic ProceedTraffic = this.Person.GetProceedTraficByDate(this.ConceptCalculateDate);
            if (ProceedTraffic != null && ProceedTraffic.HasDailyItem)
            {
                foreach (ProceedTrafficPair pair in ProceedTraffic.Pairs)
                {
                    if (pair.IsEmpty && pair.IsFilled && pair.PishcardCode == 62)
                    {
                        Result.Value = 1 * PersianDateTime.DateDifference(ProceedTraffic.FromDate, ProceedTraffic.ToDate);
                        Result.FromDate = ProceedTraffic.FromDate;
                        Result.ToDate = ProceedTraffic.ToDate;
                    }
                }
            }
            else
            {
                //if there is not traffic for this date
                Result.Value = 0;
                Result.FromDate = this.ConceptCalculateDate;
                Result.ToDate = this.ConceptCalculateDate;
            }
        }

        /// <summary>مفهوم ماموریت خالص ساعتی 53</summary>
        /// <param name="Result"></param>        
        public virtual void C2016(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ((PairableScndCnpValue)Result).Pairs.Clear();
            PairableScndCnpValue validMission = new PairableScndCnpValue();
            PairableScndCnpValue AbsentMission = new PairableScndCnpValue();
            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourDuty3));
            BaseShift shift = this.Person.GetShiftByDate(this.ConceptCalculateDate);

            if (shift != null && shift.PairCount > 0)
            {

                #region بررسی غیبت ها

                AbsentMission.AddPairs(Operation.Intersect(permit, this.DoConcept(3028)));

                ((PairableScndCnpValue)this.DoConcept(3028)).AddPairs(Operation.Differance(this.DoConcept(3028), AbsentMission));
                ((PairableScndCnpValue)this.DoConcept(3001)).AddPairs(Operation.Differance(this.DoConcept(3001), AbsentMission));
                ((PairableScndCnpValue)Result).AppendPairs(AbsentMission);

                #endregion

                #region ماموریت در ساعات غیر کاری
                //ماموریت در ساعات غیرکاری مجاز است
                if (this.DoConcept(2029).Value == 1)
                {
                    validMission = Operation.Differance(permit, shift);
                    ((PairableScndCnpValue)Result).AppendPairs(validMission);
                }

                #endregion
            }
            else//روز تعطیل 
            {
                ((PairableScndCnpValue)Result).AppendPairs(permit.Pairs);
            }

            this.ReCalculate(this.ConceptCalculateDate, 3008, 3010, 3014, 3029, 3030, 3031);
        }

        /// <summary>مفهوم ماموریت خالص ساعتی 54</summary>
        /// <param name="Result"></param>        
        public virtual void C2017(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ((PairableScndCnpValue)Result).Pairs.Clear();
            PairableScndCnpValue validMission = new PairableScndCnpValue();
            PairableScndCnpValue AbsentMission = new PairableScndCnpValue();
            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourDuty4));
            BaseShift shift = this.Person.GetShiftByDate(this.ConceptCalculateDate);

            if (shift != null && shift.PairCount > 0)
            {

                #region بررسی غیبت ها

                AbsentMission.AddPairs(Operation.Intersect(permit, this.DoConcept(3028)));

                ((PairableScndCnpValue)this.DoConcept(3028)).AddPairs(Operation.Differance(this.DoConcept(3028), AbsentMission));
                ((PairableScndCnpValue)this.DoConcept(3001)).AddPairs(Operation.Differance(this.DoConcept(3001), AbsentMission));
                ((PairableScndCnpValue)Result).AppendPairs(AbsentMission);

                #endregion

                #region ماموریت در ساعات غیر کاری
                //ماموریت در ساعات غیرکاری مجاز است
                if (this.DoConcept(2029).Value == 1)
                {
                    validMission = Operation.Differance(permit, shift);
                    ((PairableScndCnpValue)Result).AppendPairs(validMission);
                }

                #endregion
            }
            else//روز تعطیل 
            {
                ((PairableScndCnpValue)Result).AppendPairs(permit.Pairs);
            }

            this.ReCalculate(this.ConceptCalculateDate, 3008, 3010, 3014, 3029, 3030, 3031);
        }

        /// <summary>مفهوم ماموریت خالص ساعتی 55</summary>
        /// <param name="Result"></param>        
        public virtual void C2018(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ((PairableScndCnpValue)Result).Pairs.Clear();
            PairableScndCnpValue validMission = new PairableScndCnpValue();
            PairableScndCnpValue AbsentMission = new PairableScndCnpValue();
            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourDuty5));
            BaseShift shift = this.Person.GetShiftByDate(this.ConceptCalculateDate);

            if (shift != null && shift.PairCount > 0)
            {

                #region بررسی غیبت ها

                AbsentMission.AddPairs(Operation.Intersect(permit, this.DoConcept(3028)));

                ((PairableScndCnpValue)this.DoConcept(3028)).AddPairs(Operation.Differance(this.DoConcept(3028), AbsentMission));
                ((PairableScndCnpValue)this.DoConcept(3001)).AddPairs(Operation.Differance(this.DoConcept(3001), AbsentMission));
                ((PairableScndCnpValue)Result).AppendPairs(AbsentMission);

                #endregion

                #region ماموریت در ساعات غیر کاری
                //ماموریت در ساعات غیرکاری مجاز است
                if (this.DoConcept(2029).Value == 1)
                {
                    validMission = Operation.Differance(permit, shift);
                    ((PairableScndCnpValue)Result).AppendPairs(validMission);
                }

                #endregion
            }
            else//روز تعطیل 
            {
                ((PairableScndCnpValue)Result).AppendPairs(permit.Pairs);
            }

            this.ReCalculate(this.ConceptCalculateDate, 3008, 3010, 3014, 3029, 3030, 3031);
        }

        /// <summary>مفهوم ماموريت ساعتي 52</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي سي و سه-353 درنظر گرفته شده است</remarks>
        public virtual void C2019(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PairableScndCnpValue.AddPairsToScndCnpValue(this.DoConcept(2014), Result);
        }

        /// <summary>مفهوم ماموريت ساعتي 53</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي سي و سه-353 درنظر گرفته شده است</remarks>
        public virtual void C2020(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PairableScndCnpValue.AddPairsToScndCnpValue(this.DoConcept(2016), Result);
        }

        /// <summary>مفهوم ماموريت ساعتي 54</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي سي و سه-353 درنظر گرفته شده است</remarks>
        public virtual void C2021(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PairableScndCnpValue.AddPairsToScndCnpValue(this.DoConcept(2017), Result);
        }

        /// <summary>مفهوم ماموريت ساعتي 55</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي سي و سه-353 درنظر گرفته شده است</remarks>
        public virtual void C2022(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PairableScndCnpValue.AddPairsToScndCnpValue(this.DoConcept(2018), Result);
        }

        /// <summary>مفهوم مجموع ماموريت ساعتي</summary>
        /// <param name="Result"></param>
        public virtual void C2023(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PairableScndCnpValue.AddPairsToScndCnpValue(this.DoConcept(2004), Result);
            PairableScndCnpValue.AppendPairsToScndCnpValue(this.DoConcept(2019), Result);
            PairableScndCnpValue.AppendPairsToScndCnpValue(this.DoConcept(2020), Result);
            PairableScndCnpValue.AppendPairsToScndCnpValue(this.DoConcept(2021), Result);
            PairableScndCnpValue.AppendPairsToScndCnpValue(this.DoConcept(2022), Result);
        }

        /// <summary>مفهوم ماموریت خالص روزانه 63</summary>
        /// <param name="Result"></param>        
        public virtual void C2024(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ProceedTraffic ProceedTraffic = this.Person.GetProceedTraficByDate(this.ConceptCalculateDate);
            if (ProceedTraffic != null && ProceedTraffic.HasDailyItem)
            {
                foreach (ProceedTrafficPair pair in ProceedTraffic.Pairs)
                {
                    if (pair.IsEmpty && pair.IsFilled && pair.PishcardCode == 63)
                    {
                        Result.Value = 1 * PersianDateTime.DateDifference(ProceedTraffic.FromDate, ProceedTraffic.ToDate);
                        Result.FromDate = ProceedTraffic.FromDate;
                        Result.ToDate = ProceedTraffic.ToDate;
                    }
                }
            }
            else
            {
                //if there is not traffic for this date
                Result.Value = 0;
                Result.FromDate = this.ConceptCalculateDate;
                Result.ToDate = this.ConceptCalculateDate;
            }
        }

        /// <summary>مفهوم ماموریت خالص روزانه 64</summary>
        /// <param name="Result"></param>        
        public virtual void C2025(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ProceedTraffic ProceedTraffic = this.Person.GetProceedTraficByDate(this.ConceptCalculateDate);
            if (ProceedTraffic != null && ProceedTraffic.HasDailyItem)
            {
                foreach (ProceedTrafficPair pair in ProceedTraffic.Pairs)
                {
                    if (pair.IsEmpty && pair.IsFilled && pair.PishcardCode == 64)
                    {
                        Result.Value = 1 * PersianDateTime.DateDifference(ProceedTraffic.FromDate, ProceedTraffic.ToDate);
                        Result.FromDate = ProceedTraffic.FromDate;
                        Result.ToDate = ProceedTraffic.ToDate;
                    }
                }
            }
            else
            {
                //if there is not traffic for this date
                Result.Value = 0;
                Result.FromDate = this.ConceptCalculateDate;
                Result.ToDate = this.ConceptCalculateDate;
            }
        }

        /// <summary>مفهوم ماموریت خالص روزانه 65</summary>
        /// <param name="Result"></param>        
        public virtual void C2026(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.DailyDuty5));
            if (permit != null && permit.Value == 1)
            {
                Result.Value = 1;
            }
            else
            {
                Result.Value = 0;
            }
        }

        /// <summary>مفهوم ماموریت ساعتی باید با مجوز باشد</summary>
        /// <param name="Result"></param>        
        public virtual void C2027(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم ماموریت خارج از شیفت در روز کاری</summary>
        /// مکمل مفاهیم مرخصی ساعتی خالص که تنها مجوز را در شیفت(غیبت) حساب میکنند
        /// <param name="Result"></param>
        public virtual void C2028(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PairableScndCnpValue.ClearPairsValue(Result);

            ProceedTraffic ProceedTraffic = this.Person.GetProceedTraficByDate(this.ConceptCalculateDate);
            BaseShift Shift = this.Person.GetShiftByDate(this.ConceptCalculateDate);
            if (ProceedTraffic != null && ProceedTraffic.HasHourlyItem)
            {
                foreach (ProceedTrafficPair pair in ProceedTraffic.Pairs)
                {
                    if (pair.IsFilled && (pair.PishcardCode == 51 || pair.PishcardCode == 61 || pair.PishcardCode == 52 || pair.PishcardCode == 53 || pair.PishcardCode == 54 || pair.PishcardCode == 55))
                    {
                        PairableScndCnpValue validMission = new PairableScndCnpValue();
                        if (this.DoConcept(2027).Value == 1)
                        {
                            validMission = Operation.Intersect(pair, this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourDuty1)));
                            validMission.AppendPairs(Operation.Intersect(pair, this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourDuty2))));
                            validMission.AppendPairs(Operation.Intersect(pair, this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourDuty3))));
                            validMission.AppendPairs(Operation.Intersect(pair, this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourDuty4))));
                            validMission.AppendPairs(Operation.Intersect(pair, this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourDuty5))));
                        }
                        else
                        {
                            PairableScndCnpValue.AppendPairToScndCnpValue(pair, (BaseScndCnpValue)validMission);
                        }
                        if (validMission.Value > 0)
                        {
                            ((PairableScndCnpValue)Result).AppendPairs(Operation.Differance(pair, Shift));
                        }
                    }
                }
            }

            if (this.DoConcept(2027).Value == 1)
            {
                if (this.Person.GetShiftByDate(this.ConceptCalculateDate).Value > 0)
                {
                    PairableScndCnpValue present = (PairableScndCnpValue)this.DoConcept(1);
                    PairableScndCnpValue validLeave = Operation.Differance(this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourDuty1)), present);
                    validLeave.AppendPairs(Operation.Differance(this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourDuty2)), present));
                    validLeave.AppendPairs(Operation.Differance(this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourDuty3)), present));
                    validLeave.AppendPairs(Operation.Differance(this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourDuty4)), present));
                    validLeave.AppendPairs(Operation.Differance(this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.HourDuty5)), present));

                    if (validLeave.Value > 0)
                    {
                        ((PairableScndCnpValue)Result).AppendPairs(Operation.Differance(validLeave, this.Person.GetShiftByDate(this.ConceptCalculateDate)));
                    }
                }
            }
            ((PairableScndCnpValue)Result).AddPairs(Operation.Differance((PairableScndCnpValue)Result, this.Person.GetShiftByDate(this.ConceptCalculateDate)));

        }

        /// <summary>مفهوم ماموریت در ساعات غیر کاری مجاز است</summary>
        /// <param name="Result"></param>        
        public virtual void C2029(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم کار خارج از اداره</summary>
        /// <param name="Result"></param>        
        public virtual void C2030(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ((PairableScndCnpValue)Result).ClearPairs();
            ProceedTraffic ProceedTraffic = this.Person.GetProceedTraficByDate(this.ConceptCalculateDate);
            foreach (ProceedTrafficPair pair in ProceedTraffic.Pairs)
            {
                if (pair.PishcardCode == 50)
                {
                    ((PairableScndCnpValue)Result).AppendPair(pair);
                }
            }
        }

        /// <summary>مفهوم ماموریت روزانه_61</summary>
        /// <param name="Result"></param>        
        public virtual void C2031(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(2003).Value;
        }

        /// <summary>مفهوم ماموریت روزانه_62</summary>
        /// <param name="Result"></param>        
        public virtual void C2032(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(2015).Value;
        }

        /// <summary>مفهوم ماموریت روزانه_63</summary>
        /// <param name="Result"></param>        
        public virtual void C2033(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(2024).Value;
        }

        /// <summary>مفهوم ماموریت روزانه_64</summary>
        /// <param name="Result"></param>        
        public virtual void C2034(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(2025).Value;
        }

        /// <summary>مفهوم ماموریت روزانه_65</summary>
        /// <param name="Result"></param>        
        public virtual void C2035(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(2026).Value;
        }

        /// <summary>مفهوم ماموريت خالص شبانه روزی_71</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي هشتادوسه-2008 درنظر گرفته شده است</remarks>
        public virtual void C2036(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ProceedTraffic ProceedTraffic = this.Person.GetProceedTraficByDate(this.ConceptCalculateDate);
            if (ProceedTraffic != null && ProceedTraffic.HasDailyItem)
            {
                foreach (ProceedTrafficPair pair in ProceedTraffic.Pairs)
                {
                    if (pair.IsFilled && pair.PishcardCode == 71)
                    {
                        Result.Value = 1 * PersianDateTime.DateDifference(ProceedTraffic.FromDate, ProceedTraffic.ToDate);
                        Result.FromDate = ProceedTraffic.FromDate;
                        Result.ToDate = ProceedTraffic.ToDate;
                    }
                }
            }
            else
            {
                //if there is not traffic for this date
                Result.Value = 0;
                Result.FromDate = this.ConceptCalculateDate;
                Result.ToDate = this.ConceptCalculateDate;
            }
        }

        /// <summary>مفهوم ماموريت خالص شبانه روزی_72</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي هشتادوسه-2008 درنظر گرفته شده است</remarks>
        public virtual void C2037(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ProceedTraffic ProceedTraffic = this.Person.GetProceedTraficByDate(this.ConceptCalculateDate);
            if (ProceedTraffic != null && ProceedTraffic.HasDailyItem)
            {
                foreach (ProceedTrafficPair pair in ProceedTraffic.Pairs)
                {
                    if (pair.IsFilled && pair.PishcardCode == 72)
                    {
                        Result.Value = 1 * PersianDateTime.DateDifference(ProceedTraffic.FromDate, ProceedTraffic.ToDate);
                        Result.FromDate = ProceedTraffic.FromDate;
                        Result.ToDate = ProceedTraffic.ToDate;
                    }
                }
            }
            else
            {
                //if there is not traffic for this date
                Result.Value = 0;
                Result.FromDate = this.ConceptCalculateDate;
                Result.ToDate = this.ConceptCalculateDate;
            }
        }

        /// <summary>مفهوم ماموريت خالص شبانه روزی_73</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي هشتادوسه-2008 درنظر گرفته شده است</remarks>
        public virtual void C2038(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ProceedTraffic ProceedTraffic = this.Person.GetProceedTraficByDate(this.ConceptCalculateDate);
            if (ProceedTraffic != null && ProceedTraffic.HasDailyItem)
            {
                foreach (ProceedTrafficPair pair in ProceedTraffic.Pairs)
                {
                    if (pair.IsFilled && pair.PishcardCode == 73)
                    {
                        Result.Value = 1 * PersianDateTime.DateDifference(ProceedTraffic.FromDate, ProceedTraffic.ToDate);
                        Result.FromDate = ProceedTraffic.FromDate;
                        Result.ToDate = ProceedTraffic.ToDate;
                    }
                }
            }
            else
            {
                //if there is not traffic for this date
                Result.Value = 0;
                Result.FromDate = this.ConceptCalculateDate;
                Result.ToDate = this.ConceptCalculateDate;
            }
        }

        /// <summary>مفهوم ماموريت خالص شبانه روزی_74</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي هشتادوسه-2008 درنظر گرفته شده است</remarks>
        public virtual void C2039(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ProceedTraffic ProceedTraffic = this.Person.GetProceedTraficByDate(this.ConceptCalculateDate);
            if (ProceedTraffic != null && ProceedTraffic.HasDailyItem)
            {
                foreach (ProceedTrafficPair pair in ProceedTraffic.Pairs)
                {
                    if (pair.IsFilled && pair.PishcardCode == 74)
                    {
                        Result.Value = 1 * PersianDateTime.DateDifference(ProceedTraffic.FromDate, ProceedTraffic.ToDate);
                        Result.FromDate = ProceedTraffic.FromDate;
                        Result.ToDate = ProceedTraffic.ToDate;
                    }
                }
            }
            else
            {
                //if there is not traffic for this date
                Result.Value = 0;
                Result.FromDate = this.ConceptCalculateDate;
                Result.ToDate = this.ConceptCalculateDate;
            }
        }

        /// <summary>مفهوم ماموريت خالص شبانه روزی_75</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي هشتادوسه-2008 درنظر گرفته شده است</remarks>
        public virtual void C2040(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ProceedTraffic ProceedTraffic = this.Person.GetProceedTraficByDate(this.ConceptCalculateDate);
            if (ProceedTraffic != null && ProceedTraffic.HasDailyItem)
            {
                foreach (ProceedTrafficPair pair in ProceedTraffic.Pairs)
                {
                    if (pair.IsFilled && pair.PishcardCode == 3005)
                    {
                        Result.Value = 1 * PersianDateTime.DateDifference(ProceedTraffic.FromDate, ProceedTraffic.ToDate);
                        Result.FromDate = ProceedTraffic.FromDate;
                        Result.ToDate = ProceedTraffic.ToDate;
                    }
                }
            }
            else
            {
                //if there is not traffic for this date
                Result.Value = 0;
                Result.FromDate = this.ConceptCalculateDate;
                Result.ToDate = this.ConceptCalculateDate;
            }
        }

        /// <summary>مفهوم ماموریت شبانه روزی_71</summary>
        /// <param name="Result"></param>        
        public virtual void C2041(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(2036).Value;
        }

        /// <summary>مفهوم ماموریت شبانه روزی_72</summary>
        /// <param name="Result"></param>        
        public virtual void C2042(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(2037).Value;
        }

        /// <summary>مفهوم ماموریت شبانه روزی_73</summary>
        /// <param name="Result"></param>        
        public virtual void C2043(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(2038).Value;
        }

        /// <summary>مفهوم ماموریت شبانه روزی_74</summary>
        /// <param name="Result"></param>        
        public virtual void C2044(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(2039).Value;
        }

        /// <summary>مفهوم ماموریت شبانه روزی_75</summary>
        /// <param name="Result"></param>        
        public virtual void C2045(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(2040).Value;
        }

        /// <summary>مفهوم ماموریت شبانه روزی ماهانه</summary>
        /// <param name="Result"></param>        
        public virtual void C2046(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم تعطیلات رسمی بین ماموریت,ماموریت محسوب شود </summary>
        /// <param name="Result"></param>
        public virtual void C2047(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم تعطیلات غیر رسمی بین ماموریت,ماموریت محسوب شود </summary>
        /// <param name="Result"></param>
        public virtual void C2048(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم روزهای غیر کاری بین ماموریت,ماموریت محسوب شود </summary>
        /// <param name="Result"></param>
        public virtual void C2049(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم تعطیلات رسمی بین ماموریت شبانه روزی,ماموریت شبانه روزی محسوب شود </summary>
        /// <param name="Result"></param>
        public virtual void C2050(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }
    
        /// <summary>مفهوم ماموریت جزو نوبت کاری حساب شود </summary>
        /// <param name="Result"></param>
        public virtual void C2051(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        #endregion

        #region مفاهيم غيبت

        /// <summary>مفهوم غيبت خالص ساعتي</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي سي و شش-36 درنظر گرفته شده است</remarks>
        public virtual void C3001(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
            PairableScndCnpValue.ClearPairsValue(Result);
            ProceedTraffic proceedTraffic = this.Person.GetProceedTraficByDate(this.ConceptCalculateDate);
            if (proceedTraffic.IsFilled && this.DoConcept(1090).Value == 0 && this.DoConcept(2005).Value == 0 && this.DoConcept(1091).Value == 0)
            {
                if (this.Person.GetShiftByDate(this.ConceptCalculateDate).ShiftType != ShiftTypesEnum.OVERTIME)
                {
                    if (this.Person.GetShiftByDate(this.ConceptCalculateDate).Value > 0 && proceedTraffic != null && (proceedTraffic.HasHourlyItem || (!proceedTraffic.HasHourlyItem && !proceedTraffic.HasDailyItem)))
                    {
                        ((PairableScndCnpValue)Result).AddPairs(Operation.Differance(this.Person.GetShiftByDate(this.ConceptCalculateDate), proceedTraffic));
                    }
                    else if (this.Person.GetShiftByDate(this.ConceptCalculateDate).Value > 0 && proceedTraffic == null)
                    {
                        ((PairableScndCnpValue)Result).AppendPairs(this.Person.GetShiftByDate(this.ConceptCalculateDate).Pairs);
                    }
                    else
                    {
                        Result.Value = 0;
                    }
                }
                else
                {
                    Result.Value = 0;
                }
            }
        }

        /// <summary>مفهوم کل تاخیر یا تعجیل بیش از حد مجاز روزانه غیبت حساب شود</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي سي و هفت-3002 درنظر گرفته شده است</remarks>
        public virtual void C3002(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }
    
        /// <summary>مفهوم غيبت خالص روزانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي هفتاد-3003 درنظر گرفته شده است</remarks>
        public virtual void C3003(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم غيبت روزانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي یکصدو سی و دو-132 درنظر گرفته شده است</remarks>
        public virtual void C3004(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(3003).Value;
        }

        /// <summary>مفهوم غيبت خالص روزانه ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي هفتاد و پنج-3005 درنظر گرفته شده است</remarks>
        public virtual void C3005(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم کل تاخیر یا تعجیل بیش از حد مجاز ماهانه غیبت حساب شود</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي سي و هفت-3002 درنظر گرفته شده است</remarks>
        public virtual void C3006(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم غيبت ساعتي سالانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي چهل و يک-41 درنظر گرفته شده است</remarks>
        public virtual void C3007(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم تاخير خالص ساعتي</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي چهل و دو-42 درنظر گرفته شده است</remarks>
        public virtual void C3008(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
            PairableScndCnpValue.ClearPairsValue(Result);
            ProceedTraffic proceedTraffic = Person.GetProceedTraficByDate(this.ConceptCalculateDate);
            this.DoConcept(3038).Value = 0;
            if (this.DoConcept(1090).Value == 0 && this.DoConcept(2005).Value == 0 && this.DoConcept(1091).Value == 0)
            {
                PairableScndCnpValue absent = (PairableScndCnpValue)this.DoConcept(3001);
                BaseShift shift = this.Person.GetShiftByDate(this.ConceptCalculateDate);

                if (absent != null && shift != null && absent.PairCount != 0 && shift.PairCount != 0)
                {
                    if (proceedTraffic != null && proceedTraffic.Pairs.Where(x => x.IsFilled).Count() > 0
                        && Operation.Intersect(this.Person.GetShiftByDate(this.ConceptCalculateDate), proceedTraffic).Value > 0)
                    {
                        IPair pair = proceedTraffic.Pairs.Where(x => x.IsFilled).OrderBy(x => x.From).First();
                        foreach (ShiftPair shiftPair in shift.Pairs.OrderBy(x => x.From).ToList())
                        {
                            PairableScndCnpValue p = Operation.Intersect(shiftPair, absent);
                            if (p.PairCount > 0 && p.Pairs.OrderBy(x => x.From).First().From ==
                               shiftPair.From)
                            {
                                PairableScndCnpValue val = Operation.Differance(p.Pairs.OrderBy(x => x.From).First(), pair);
                                PairableScndCnpValue.AppendPairToScndCnpValue(val.Pairs.First(), Result);
                                this.DoConcept(3038).Value += 1;
                                //break;
                            }
                        }
                    }
                    else
                    {
                        //در نظر گرفتن کل غیبت
                        foreach (ShiftPair shiftPair in shift.Pairs.OrderBy(x => x.From).ToList())
                        {
                            PairableScndCnpValue p = Operation.Intersect(shiftPair, absent);
                            if (p.PairCount > 0 && p.Pairs.OrderBy(x => x.From).First().From ==
                               shiftPair.From)
                            {
                                PairableScndCnpValue.AppendPairToScndCnpValue(p.Pairs.OrderBy(x => x.From).First(), Result);
                                this.DoConcept(3038).Value += 1;
                            }
                        }
                    }
                }
            }
        }    

        /// <summary>مفهوم تاخيرخالص ساعتي ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي چهل و شش-3009 درنظر گرفته شده است</remarks>
        public virtual void C3009(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم تعجيل خالص ساعتي</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي چهل و هفت-47 درنظر گرفته شده است</remarks>
        public virtual void C3010(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
            PairableScndCnpValue.ClearPairsValue(Result);
            if (this.DoConcept(1090).Value == 0 && this.DoConcept(2005).Value == 0 && this.DoConcept(1091).Value == 0)
            {
                ProceedTraffic proceedTraffic = this.Person.GetProceedTraficByDate(this.ConceptCalculateDate);
                if (proceedTraffic != null && proceedTraffic.PairCount > 0)
                {
                    PairableScndCnpValue absent = (PairableScndCnpValue)this.DoConcept(3001);
                    PairableScndCnpValue present = (PairableScndCnpValue)this.DoConcept(1);
                    BaseShift shift = this.Person.GetShiftByDate(this.ConceptCalculateDate);
                    if (Operation.Intersect(shift, proceedTraffic).Value > 0)
                    {
                        if (absent != null && shift != null && absent.PairCount != 0 && shift.PairCount != 0)
                        {
                            if (absent.Pairs
                                .Where(x => x.To == shift.Last.To)
                                        .FirstOrDefault() != null
                              )
                            {
                                PairableScndCnpValue.AddPairToScndCnpValue(absent.Pairs.OrderBy(x => x.To).ToList().Last(), Result);
                            }
                        }
                    }
                }
            }
        }

        /// <summary>مفهوم تعجيل خالص ساعتي ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي چهل و نه-49 درنظر گرفته شده است</remarks>
        public virtual void C3011(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم مدت تعجيل مجاز</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي پنجاه-50 درنظر گرفته شده است</remarks>
        public virtual void C3012(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {

            Result.Value = 0;
        }

        /// <summary>مفهوم مدت تعجيل مجازماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي پنجاه و يک-51 درنظر گرفته شده است</remarks>
        public virtual void C3013(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم غيبت بين وقت خالص ساعتي</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي پنجاه و دو-52 درنظر گرفته شده است</remarks>
        public virtual void C3014(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            int i = 0;
            Result.Value = 0;
            PairableScndCnpValue.ClearPairsValue(Result);
            PairableScndCnpValue absent = (PairableScndCnpValue)this.DoConcept(3001);
            BaseShift shift = this.Person.GetShiftByDate(this.ConceptCalculateDate);
            if (absent != null && shift != null)
            {
                while (i <= absent.PairCount - 1)
                {

                    if ((shift.Pairs
                                .Where(x => x.To == absent.PairPart(i).To && shift.Pairs.Max(y => y.To) == x.To)
                                .FirstOrDefault() == null) &&
                        (shift.Pairs
                                .Where(x => x.From == absent.PairPart(i).From && shift.Pairs.Min(y => y.From) == x.From)
                                .FirstOrDefault() == null))
                    {
                        PairableScndCnpValue.AppendPairToScndCnpValue(absent.PairPart(i), Result);
                    }
                    i++;
                }
                PairableScndCnpValue.AddPairsToScndCnpValue(Operation.Differance(Result, this.DoConcept(3008)), Result);
            }
        }

        /// <summary>مفهوم غيبت ساعتي در استراحت بين وقت</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي هشتادويک-81 درنظر گرفته شده است</remarks>
        public virtual void C3015(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ((PairableScndCnpValue)Result).AddPairs(Operation.Differance(this.DoConcept(5002), this.DoConcept(1)));
            ((PairableScndCnpValue)Result).AppendPairs(Operation.Differance(Result, this.DoConcept(1002)));
            ((PairableScndCnpValue)Result).AppendPairs(Operation.Differance(Result, this.DoConcept(2002)));
        }

        /// <summary>مفهوم غيبت بين وقت خالص ساعتي ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي هفتادونه-79 درنظر گرفته شده است</remarks>
        public virtual void C3016(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم مدت غيبت بين وقت مجاز</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي پنجاه و سه-53 درنظر گرفته شده است</remarks>
        public virtual void C3017(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {

            Result.Value = 0;
        }

        /// <summary>مفهوم مدت غيبت بين وقت مجازماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي پنجاه و چهار-54 درنظر گرفته شده است</remarks>
        public virtual void C3018(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {

            Result.Value = 0;
        }

        /// <summary>مفهوم غيبت درروز</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي پنجاه و پنج-55 درنظر گرفته شده است</remarks>
        public virtual void C3019(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم غيبت ساعتی مجاز</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي نود و یک-91 درنظر گرفته شده است</remarks>
        public virtual void C3020(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = this.DoConcept(3021).Value + this.DoConcept(3022).Value + this.DoConcept(3023).Value;
        }

        /// <summary>مفهوم تاخیر ساعتی مجاز</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي نود و دو-3021 درنظر گرفته شده است</remarks>
        public virtual void C3021(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم تعجیل ساعتی مجاز</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي نود و سه-3022 درنظر گرفته شده است</remarks>
        public virtual void C3022(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم غیبت بین وقت ساعتی مجاز</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي نود و چهار-3023 درنظر گرفته شده است</remarks>
        public virtual void C3023(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم تاخیر ساعتی مجاز ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي نود و پنج-3024 درنظر گرفته شده است</remarks>
        public virtual void C3024(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم تعجیل ساعتی مجاز ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي نود و شش-3025 درنظر گرفته شده است</remarks>
        public virtual void C3025(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم غیبت ساعتی مجاز ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي نود و هفت-3026 درنظر گرفته شده است</remarks>
        public virtual void C3026(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;

            //Result.Value = this.DoConcept(3024).Value + this.DoConcept(3025).Value + this.DoConcept(3027).Value;
            //Result.FromDate = this.DoConcept(3024).FromDate;
            //Result.ToDate = this.DoConcept(3024).ToDate;
            //Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم غیبت بین وقت ساعتی مجاز ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي نود و هشت-98 درنظر گرفته شده است</remarks>
        public virtual void C3027(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم غيبت ساعتی غیرمجاز</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي نود و یک-99 درنظر گرفته شده است</remarks>
        public virtual void C3028(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ((PairableScndCnpValue)Result).ClearPairs();
            ((PairableScndCnpValue)Result).AddPairs(Operation.Union(Operation.Union(this.DoConcept(3029), this.DoConcept(3030)), this.DoConcept(3031)));
        }

        /// <summary>مفهوم تاخیر ساعتی غیرمجاز</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي صد-3029 درنظر گرفته شده است</remarks>
        public virtual void C3029(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ((PairableScndCnpValue)Result).AddPairs(this.DoConcept(3008));
        }

        /// <summary>مفهوم تعجیل ساعتی غیرمجاز</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي صد و یک-3030 درنظر گرفته شده است</remarks>
        public virtual void C3030(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ((PairableScndCnpValue)Result).AddPairs(this.DoConcept(3010));
        }

        /// <summary>مفهوم غیبت بین وقت ساعتی غیرمجاز</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي صد و بیست و یک-3031 درنظر گرفته شده است</remarks>
        public virtual void C3031(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ((PairableScndCnpValue)Result).AddPairs(this.DoConcept(3014));
        }

        /// <summary>مفهوم تاخیر ساعتی غیرمجاز ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي صد و بیست و یک-3032 درنظر گرفته شده است</remarks>
        public virtual void C3032(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم تعجیل ساعتی غیرمجاز ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي صد و بیست و دو-3033 درنظر گرفته شده است</remarks>
        public virtual void C3033(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم غیبت ساعتی غیرمجاز ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي صد و بیست و سه-3034 درنظر گرفته شده است</remarks>
        public virtual void C3034(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم غیبت بین وقت ساعتی غیرمجاز ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي صد و بیست و چهار-3035 درنظر گرفته شده است</remarks>
        public virtual void C3035(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم تعداد بازه های تعجیل</summary>
        /// <param name="Result"></param>      
        public virtual void C3036(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم جریمه تاخیر</summary>
        /// <param name="Result"></param>      
        public virtual void C3037(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }
     
        /// <summary>مفهوم تعداد بازه های تاخیر</summary>
        /// <param name="Result"></param>         
        public virtual void C3038(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم تعداد بازه های تاخیر ماهانه</summary>
        /// <param name="Result"></param>         
        public virtual void C3039(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        #endregion

        #region مفاهيم اضافه کاري

        /// <summary>مفهوم اضافه کارخالص ساعتي</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي پنجاه و شش-56 درنظر گرفته شده است</remarks>
        public virtual void C4001(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ((PairableScndCnpValue)Result).AddPairs(Operation.Differance(
                                                        Operation.Differance(this.DoConcept(1),
                                                                             this.Person.GetShiftByDate(this.ConceptCalculateDate)
                                                                            ), this.DoConcept(5002)));
        }

        /// <summary>مفهوم اضافه کارساعتي مجاز</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي یکصدو بیست و پنج-125 درنظر گرفته شده است</remarks>
        public virtual void C4002(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ((PairableScndCnpValue)Result).AddPairs(Operation.Differance(this.DoConcept(4001), this.DoConcept(4017)));
            ((PairableScndCnpValue)Result).AddPairs(Operation.Differance(Result, this.DoConcept(5002)));
        }

        /// <summary>مفهوم اضافه کارساعتي غیرمجاز</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي یکصدوبیست و شش-126 درنظر گرفته شده است</remarks>
        public virtual void C4003(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم اضافه کارساعتي ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي پنجاه و هشت-58 درنظر گرفته شده است</remarks>
        public virtual void C4004(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم اضافه کارساعتي مجاز ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks></remarks>
        public virtual void C4005(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;

            //Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, true, EngEnvironment.GetPrecard(Precards.OrderedOverTime));
            //Result.Value += permit.PairValues;
        }

        /// <summary>مفهوم اضافه کارساعتي غیرمجاز ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي یکصدو بیست و هشت-128 درنظر گرفته شده است</remarks>
        public virtual void C4006(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }
    
        /// <summary>مفهوم اضافه کارآخروقت</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي شصت-60 درنظر گرفته شده است</remarks>
        /// نام درست اين مفهوم اضافه کاربعدازوقت است
        public virtual void C4007(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ((PairableScndCnpValue)Result).ClearPairs();

            int i = 0;
            PairableScndCnpValue overTime = (PairableScndCnpValue)this.DoConcept(4002);
            BaseShift shift = this.Person.GetShiftByDate(this.ConceptCalculateDate);
            while (i <= overTime.PairCount - 1)
            {
                if (shift.Pairs
                            .Where(x => x.To < overTime.PairPart(i).To)
                            .FirstOrDefault() != null)
                {
                    ((PairableScndCnpValue)Result).AppendPair(overTime.PairPart(i));
                }
                i++;
            }
        }

        /// <summary>مفهوم اضافه کاراول وقت</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي شصت و دو-62 درنظر گرفته شده است</remarks>
        public virtual void C4008(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            int i = 0;
            ((PairableScndCnpValue)Result).Pairs.Clear();
            PairableScndCnpValue overTime = (PairableScndCnpValue)this.DoConcept(4002);
            BaseShift shift = this.Person.GetShiftByDate(this.ConceptCalculateDate);
            while (i <= overTime.PairCount - 1)
            {

                if (shift.Pairs
                            .Where(x => x.From > overTime.PairPart(i).From)
                            .FirstOrDefault() != null)
                {
                    ((PairableScndCnpValue)Result).AppendPair(overTime.PairPart(i));
                }
                i++;
            }
        }
 
        /// <summary>مفهوم اضافه کارساعتي تعطيل</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي شصت و چهار-64 درنظر گرفته شده است</remarks>
        public virtual void C4009(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            if (EngEnvironment.HasCalendar(this.ConceptCalculateDate, "1", "2"))
            {
                ((PairableScndCnpValue)Result).AddPairs(this.DoConcept(4001));
            }
        }

        /// <summary>مفهوم اضافه کارساعتي تعطيل ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي شصت و پنج-65 درنظر گرفته شده است</remarks>
        public virtual void C4010(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم اضافه کارساعتي شب تعطيل</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي شصت و شش-66 درنظر گرفته شده است</remarks>
        public virtual void C4011(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ((PairableScndCnpValue)Result).AddPairs(Operation.Intersect(this.DoConcept(4009), this.DoConcept(14)).Pairs);
        }

        /// <summary>مفهوم اضافه کارساعتي مجازشب</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي یکصدو بیست و نه-129 درنظر گرفته شده است</remarks>
        public virtual void C4012(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ((PairableScndCnpValue)Result).AddPairs(Operation.Intersect(this.DoConcept(4002), this.DoConcept(14)));
        }
     
        /// <summary>مفهوم اضافه کارساعتی جمعه</summary>
        /// <param name="Result"></param>     
        public virtual void C4013(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            if (this.ConceptCalculateDate.DayOfWeek == DayOfWeek.Friday)
            {
                ((PairableScndCnpValue)Result).AddPairs(((PairableScndCnpValue)this.DoConcept(4001)).Pairs);
            }
        }

        /// <summary>مفهوم اضافه کار مجاز بين وقت</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي پنجاه و دو-52 درنظر گرفته شده است</remarks>
        public virtual void C4014(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ((PairableScndCnpValue)Result).AddPairs(Operation.Intersect(this.DoConcept(1), this.DoConcept(5002)));
        }

        /// <summary>مفهوم اضافه کار با مجوز باشد</summary>
        /// <param name="Result"></param>
        public virtual void C4015(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم اضافه کار بعد از وقت مجوزی است</summary>
        /// <param name="Result"></param>
        public virtual void C4016(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }
       
        /// <summary>مفهوم اضافه کار مجاز کارتی </summary>
        /// <param name="Result"></param>
        public virtual void C4017(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ProceedTraffic ProceedTraffic = new ProceedTraffic();
            foreach (ProceedTrafficPair pair in this.Person.GetProceedTraficByDate(this.ConceptCalculateDate).Pairs)
            {
                if (pair.PishcardCode == 28 || pair.PishcardCode == 3)
                {
                    ProceedTraffic.Pairs.Add(pair);
                }
            }
            ((PairableScndCnpValue)Result).AddPairs(Operation.Intersect(this.DoConcept(4001), ProceedTraffic));
        }

        /// <summary>مفهوم حداکثر اضافه کار مجاز ماهانه </summary>
        /// <param name="Result"></param>
        public virtual void C4018(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم اضافه کار قبل از وقت ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks></remarks>
        public virtual void C4019(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم اضافه کار بین وقت ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks></remarks>
        public virtual void C4020(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم اضافه کار بعد از وقت ماهانه</summary>
        /// <param name="Result"></param>
        /// <remarks></remarks>
        public virtual void C4021(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم تعطیل کاری</summary>
        /// <remarks>!نام دیگر این مفهوم اضافه کار روزانه است!</remarks>
        /// <param name="Result"></param>     
        public virtual void C4022(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم زمان ناهار</summary>
        /// <param name="Result"></param>     
        public virtual void C4023(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم تبدیل حضور به اضافه کار در روز غیبت</summary>
        /// <param name="Result"></param>     
        public virtual void C4024(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم تبدیل حضور به اضافه کار در روز مرخصی</summary>
        /// <param name="Result"></param>     
        public virtual void C4025(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم سقف اضافه کار که ضریب تعلق میگیرد</summary>
        /// <param name="Result"></param>     
        public virtual void C4026(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم ضریب اول اضافه کار</summary>
        /// <param name="Result"></param>     
        public virtual void C4027(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم ضریب دوم اضافه کار</summary>
        /// <param name="Result"></param>     
        public virtual void C4028(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم مجوز اضافه کاری</summary>
        /// <param name="Result"></param>
        public virtual void C4029(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.OverTime));
            ((PairableScndCnpValue)Result).AddPairs(permit);
            Result.Value = permit.Value;
        }


      

        #endregion

        #region مفاهيم متفرقه

        /// <summary>مفهوم اياب وذهاب</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي هفتاد و دو-72 درنظر گرفته شده است</remarks>
        public virtual void C5001(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم استراحت بين وقت</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي شصت و نه-5002 درنظر گرفته شده است</remarks>
        public virtual void C5002(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            BaseShift shift = this.Person.GetShiftByDate(this.ConceptCalculateDate);
            if (shift.Pairs.Count > 0)
            {
                ((PairableScndCnpValue)Result).AddPairs(Operation.Differance(new PairableScndCnpValuePair(shift.First.From, shift.Last.To), shift));
            }
        }

        /// <summary>مفهوم جمعه کاري</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي هفتاد و يک-71 درنظر گرفته شده است</remarks>
        public virtual void C5003(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }         

        /// <summary>مفهوم حق غذا</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي هفتاد و سه-73 درنظر گرفته شده است</remarks>
        public virtual void C5004(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم تعداد نوبت کاري 10</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي هفتاد و چهار-74 درنظر گرفته شده است</remarks>
        public virtual void C5005(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }        
    
        /// <summary>مفهوم کشیک</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي نود-140 درنظر گرفته شده است</remarks>
        public virtual void C5006(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم جانباز</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين مفهوم در تعاريف بعدي نود-141 درنظر گرفته شده است</remarks>
        public virtual void C5007(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم نوع</summary>
        /// <param name="Result"></param>      
        public virtual void C5008(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            //تقویم تعطیل رسمی 1
            //تعطیل غیر رسمی 2

            if (Person.GetShiftByDate(this.ConceptCalculateDate).Value == 0)
            {
                Result.Value = 1;
            }
            if (EngEnvironment.HasCalendar(this.ConceptCalculateDate, "2"))
            {
                Result.Value |= 2;
            }
            if (EngEnvironment.HasCalendar(this.ConceptCalculateDate, "1"))
            {
                Result.Value |= 4;
            }
        }

        /// <summary>مفهوم نوع روز</summary>
        /// <param name="Result"></param>      
        public virtual void C5009(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            if (this.DoConcept(1005).Value > 0)
                Result.Value = 41;
            else
                if (this.DoConcept(1065).Value > 0)
                    Result.Value = 32;
                else
                    if (this.DoConcept(2003).Value > 0)
                        Result.Value = 61;
                    else
                        if (this.DoConcept(2015).Value > 0)
                            Result.Value = 62;
                        else
                            if (this.DoConcept(2024).Value > 0)
                                Result.Value = 63;
                            else
                                if (this.DoConcept(2025).Value > 0)
                                    Result.Value = 64;
                                else
                                    if (this.DoConcept(2026).Value > 0)
                                        Result.Value = 65;
                                    else
                                        if (this.DoConcept(3003).Value > 0)
                                            Result.Value = 91;
                                        else
                                            if (this.DoConcept(1010).Value > 0)
                                                Result.Value = 42;
                                            else
                                                if (this.DoConcept(1003).Value > 0)
                                                    Result.Value = 21;
                                                else
                                                    if (this.DoConcept(2008).Value > 0)
                                                        Result.Value = 71;
                                                    else
                                                        if (this.DoConcept(2004).Value > 0)
                                                            Result.Value = 51;
                                                        //else
                                                        //    if (this.DoConcept(165).Value > 0)
                                                        //        Result.Value = 81;
                                                        else
                                                        {
                                                            ProceedTraffic ProceedTraffic = this.Person.GetProceedTraficByDate(this.ConceptCalculateDate);
                                                            if (ProceedTraffic != null && ProceedTraffic.HasHourlyItem)
                                                            {
                                                                foreach (ProceedTrafficPair pair in ProceedTraffic.Pairs)
                                                                {
                                                                    if (!pair.IsFilled)
                                                                    {
                                                                        Result.Value = 10;
                                                                        break;
                                                                    }
                                                                }
                                                            }
                                                        }

        }

        /// <summary>مفهوم ثبت دستی</summary>
        /// <param name="Result"></param>      
        public virtual void C5010(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            //List<BasicTraffic> l = Person.BasicTrafficList.OrderBy(x => x.Date).ToList();
            int count = Person.BasicTrafficList
                    .Where(x => x.Date.Date == this.ConceptCalculateDate.Date && x.Manual).Count();
            if (count > 0)
            {
                Result.Value = 1;
            }
            else
            {
                Result.Value = 0;
            }
        }

        /// <summary>مفهوم تلورانس خارج از مجوز</summary>
        /// <param name="Result"></param>      
        public virtual void C5011(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {

            Result.Value = 0;
        }
      
        /// <summary>مفهوم کد وضعیت روز جهت رنگ</summary>
        /// <param name="Result"></param>      
        public virtual void C5012(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم کد وضعیت روز جهت رنگ ماهانه</summary>
        /// <param name="Result"></param>      
        public virtual void C5013(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم کارکرد لازم برای حق غذا</summary>
        /// <param name="Result"></param>      
        public virtual void C5014(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم کارکرد لازم برای حق غذا ماهانه</summary>
        /// <param name="Result"></param>      
        public virtual void C5015(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم طول دوره محدوده محاسبات ماهانه</summary>
        /// <param name="Result"></param>      
        public virtual void C5016(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            DateRange dateRange = this.Person.GetPeriodicScndCnpRange(Result.Concept, this.ConceptCalculateDate);
            Result.Value = PersianDateTime.DateDifference(dateRange.FromDate, dateRange.ToDate);
            Result.FromDate = dateRange.FromDate;
            Result.ToDate = dateRange.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;
        }

        /// <summary>مفهوم حضور منهای اضافه کار در گانت چارت استفاده می گردد</summary>
        /// <param name="Result"></param>      
        public virtual void C5017(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            ((PairableScndCnpValue)Result).AddPairs(Operation.Intersect(this.DoConcept(1), this.Person.GetShiftByDate(this.ConceptCalculateDate)));
        }

        /// <summary>مفهوم پایان شبانه روز</summary>
        /// <param name="Result"></param>      
        public virtual void C5018(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            Result.Value = 0;
        }

        /// <summary>مفهوم خنثی کردن غیبت توسط مرخصی</summary>
        /// <param name="Result"></param>      
        public virtual void C164(BaseScndCnpValue Result, SecondaryConcept MyConcept)
        {
            //1004 مرخصی روزانه استحقاقی
            //1066 مرخصی بی حقوق روزانه_32
            //3003 غیبت خالص روزانه

            if (this.DoConcept(1004).Value > 0)
            {
                if (this.DoConcept(3004).Value >= this.DoConcept(1004).Value)
                {
                    this.DoConcept(3004).Value -= this.DoConcept(1004).Value;
                }
                else
                {
                    this.DoConcept(3004).Value = 0;
                }
            }
            else
            {
                if (this.DoConcept(1066).Value > 0)
                {
                    if (this.DoConcept(3004).Value >= this.DoConcept(1066).Value)
                    {
                        this.DoConcept(3004).Value -= this.DoConcept(1066).Value;
                    }
                    else
                    {
                        this.DoConcept(3004).Value = 0;
                    }
                }
            }
        }

        #endregion

        #endregion
    }
}
