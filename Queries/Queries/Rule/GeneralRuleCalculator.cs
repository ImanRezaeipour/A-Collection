using System;
using System.Globalization;
using System.Linq;
using System.Collections.Generic;
using GTS.Clock.Model;
using System.Reflection;
using GTS.Clock.Infrastructure.Exceptions;
using GTS.Clock.Infrastructure.Log;
using GTS.Clock.Infrastructure.Utility;
using GTS.Clock.Model.Concepts;
using GTS.Clock.Model.Concepts.Operations;
using GTS.Clock.Model.AppSetting;
using GTS.Clock.Model.ELE;
using GTS.Clock.Business.AppSettings;

namespace GTS.Clock.Business.Calculator
{
    public abstract class GeneralRuleCalculator : ObjectCalculator, IDisposable
    {
        #region Constants
        /// <summary>
        /// هر جا در قوانين نياز بود که پارامتري استفاده شود از اينجا استفاده ميشود و در آينده جايگزين ميگردد
        /// </summary>
        public enum Parameters
        {
            FirstParameter = 1,
            SecondParameter = 2,
            ThirdParameter = 3,
            FourthParameter = 4,
            FifthParameter = 5,
            SixthParameter = 6,
            SeventhParameter = 7,
            EighthParameter = 8,
            NinthParameter = 9,
            TenthParameter = 10,
            EleventhParameter = 11,
            TwelfthParameter = 12
        };
        protected const int HourMin = 60;
        const string SettingsLoaded = "RuleSettingsLoaded";

        #endregion

        #region Vairables

        protected static ApplicationSettings appSet;
        protected GeneralConceptCalculator CnpCalculator;
        protected GTSEngineLogger gtsRuleLogger;
        protected bool logLock = true;

        #endregion

        #region Constructors
        /// <summary>
        /// ."تنها سازنده کلاس "محاسبه گر اشياء
        /// </summary>
        /// <param name="Person">پرسنلي که محاسبات براي او در حال انجام است</param>
        /// <param name="CategorisedRule">قانوني که منجر به فراخواني مفاهيم از کلاس "محاسبه گر قانون" خواهد شد</param>
        /// <param name="CalculateDate">تاريخ انجام محاسبات</param>
        public GeneralRuleCalculator(IEngineEnvironment engineEnvironment, GeneralConceptCalculator conceptCalculator)
            : base(engineEnvironment)
        {
            this.CnpCalculator = conceptCalculator;
            this.logLock = !GTSAppSettings.RuleDebug;
        }
        #endregion

        #region Properties

        public bool LogLock
        {
            get { return logLock; }
            set { logLock = value; }
        }

        public static ApplicationSettings GTSAppSettings
        {
            get
            {
                if (appSet == null || System.Runtime.Remoting.Messaging.CallContext.GetData(SettingsLoaded) == null)
                {
                    appSet = AppSettings.BApplicationSettings.CurrentApplicationSettings;
                }
                return appSet;
            }
        }


        #endregion

        #region Methods

        /// <summary>
        /// فراخواني متد قانون مشخص شده در خصوصيت "قانون دسته بندي شده" را برعهده دارد
        /// </summary>
        public void ExecuteRule()
        {
            try
            {
                base.GetType().InvokeMember(this.MethodName(this.AssignedRule.IdentifierCode), BindingFlags.InvokeMethod, null, this, new object[1] { this.AssignedRule });
            }
            catch (MissingMethodException ex)
            {
                throw new ExecuteRuleException(String.Format("تابع {0} معرف قانون {1} موجود نيست", this.MethodName(this.AssignedRule.IdentifierCode), this.AssignedRule.Name),
                                         ExceptionType.CRASH,
                                         String.Format("ConceptCalculatro.ExecuteRule({0}.{1})", this.AssignedRule.Name, this.MethodName(this.AssignedRule.IdentifierCode)),
                                         ex);
            }
            catch (TargetInvocationException ex)
            {
                throw new ExecuteRuleException(String.Format(".خطا در اجراي قانون {0}، پیغام: {1}", this.MethodName(this.AssignedRule.IdentifierCode), Utility.GetExecptionMessage(ex)),
                                                ExceptionType.CRASH,
                                                 "ExecuteRule.InvokeMember()",
                                                 ex);
            }
            catch (Exception ex)
            {
                throw new ExecuteRuleException(String.Format(".خطا در اجراي قانون {0}، پیغام: {1}", this.MethodName(this.AssignedRule.IdentifierCode), Utility.GetExecptionMessage(ex)),
                                                    ExceptionType.CRASH,
                                                     "ExecuteRule.InvokeMember()",
                                                     ex);
            }

        }

        public string MethodName(decimal IdentitierCode)
        {
            return String.Format("R{0}", IdentitierCode.ToString());
        }

        public virtual void ReCalculate(decimal IdentifierCode)
        {
            this.ReCalculate(IdentifierCode, this.RuleCalculateDate);
        }

        public virtual void ReCalculate(params decimal[] IdentifiersCode)
        {
            for (int i = 0; i < IdentifiersCode.Length; i++)
            {
                this.ReCalculate(IdentifiersCode[i], this.RuleCalculateDate);
            }
        }

        public virtual void ReCalculate(decimal IdentifierCode, DateTime CalculateDate)
        {
            if (CalculateDate >= this.MinAssgnRuleDate)
            {
                this.CnpCalculator.ReCalculate(IdentifierCode, CalculateDate);
            }
        }

        protected BaseScndCnpValue GetConcept(decimal IdentifierCode, DateTime CalculateDate)
        {
            if (CalculateDate >= this.MinAssgnRuleDate)
            {
                return this.CnpCalculator.GetConcept(IdentifierCode, CalculateDate);
            }
            return new PairableScndCnpValue();
        }

        public BaseScndCnpValue DoConcept(decimal IdentifierCode)
        {
            return this.CnpCalculator.DoConcept(IdentifierCode, this.RuleCalculateDate);
        }

        public BaseScndCnpValue DoConcept(decimal IdentifierCode, DateTime CalculateDate)
        {
            if (CalculateDate >= this.MinAssgnRuleDate)
            {
                return this.CnpCalculator.DoConcept(IdentifierCode, CalculateDate);
            }
            return new PairableScndCnpValue();
        }

        protected void GetLog(AssignedRule rule, string Message, params int[] ConceptsId)
        {
            if (!logLock)
            {
                Array.Sort(ConceptsId);
                string msg = String.Format("Barcode:{0} - Calculation Date:{1} - Order:{2} - {3}-{4}", this.Person.BarCode, this.RuleCalculateDate.ToString(), rule.Order, this.MethodName(rule.IdentifierCode), Message);
                foreach (int cnpId in ConceptsId)
                {
                    msg += String.Format("  --- C{0} : {1} ---  ", cnpId.ToString(), this.DoConcept(cnpId).ExValue.ToString());
                }
                if (gtsRuleLogger == null)
                    gtsRuleLogger = new GTSEngineLogger();
                gtsRuleLogger.Logger.Info(msg);
                gtsRuleLogger.Flush();
            }
        }

        #endregion

        #region Defined Methods

        #region قوانين متفرقه

        /// <summary>قانون متفرقه 1-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي يک-1 درنظر گرفته شده است</remarks>
        /// متفرقه 1-1: کليه غيبتهاي ساعتي به مرخصي تبديل شود
        public virtual void R1(AssignedRule MyRule)
        {
            //1003 مرخصي استحقاقي ساعتي
            //110 مفهوم مرخصي بايد به کارکرد خالص اضافه شود
            //2 مفهوم کارکردخالص ساعتي
            //3028 غيبت ساعتي غيرمجاز
            //1088 مفهوم مرخصی به کارکرد خالص اضافه شود
            GetLog(MyRule, " Before Execute State:", 1003, 3028);
            int remain = this.Person.GetRemainLeave(this.RuleCalculateDate);
            if (remain > 0)
            {
                if (remain >= this.DoConcept(3028).Value)
                {
                    this.DoConcept(1003).Value += this.DoConcept(3028).Value;
                    this.Person.AddUsedLeave(this.RuleCalculateDate, this.DoConcept(3028).Value, null);
                    this.DoConcept(3028).Value = 0;
                }
                else
                {
                    this.DoConcept(1003).Value += remain;
                    this.Person.AddUsedLeave(this.RuleCalculateDate, remain, null);
                    this.DoConcept(3028).Value -= remain;
                }
                //اولویت فانون 79 قبل از این قانون است
                if (this.DoConcept(1088).Value == 1)
                {
                    this.DoConcept(2).Value += this.DoConcept(1003).Value;
                    this.DoConcept(13).Value += this.DoConcept(1003).Value;
                }
            }
            GetLog(MyRule, " After Execute State:", 1003, 3028);
        }

        /// <summary>قانون متفرقه 1-2</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي دو-2 درنظر گرفته شده است</remarks>
        public virtual void R2(AssignedRule MyRule)
        {
            //1005 مرخصي استحقاقي روزانه
            //3004 غيبت روزانه
            //1001 مرخصي درروز

            GetLog(MyRule, " Before Execute State:", 1005, 3004);
            int remain = this.Person.GetRemainLeave(this.RuleCalculateDate);
            if (remain >= this.DoConcept(3004).Value * this.DoConcept(1001).Value)
            {
                if (this.DoConcept(3004).Value > 0)
                {
                    this.DoConcept(1005).Value = this.DoConcept(3004).Value;
                    this.Person.AddUsedLeave(this.RuleCalculateDate, this.DoConcept(3004).Value * this.DoConcept(1001).Value, null);
                    this.DoConcept(3004).Value = 0;
                }
            }
            GetLog(MyRule, " After Execute State:", 1005, 3004);
        }

        /// <summary>قانون متفرقه 2-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي سه-3 درنظر گرفته شده است</remarks>
        public virtual void R3(AssignedRule MyRule)
        {
            //1011 مرخصي استحقاقي ساعتي ماهانه
            //غيبت ساعتي غيرمجاز ماهانه 3034
            //3026 غيبت ساعتي مجاز ماهانه
            //8 کارکردخالص ساعتي ماهانه
            //110 مفهوم مرخصي بايد به کارکرد خالص اضافه شود
            //3 کارکردناخالص ماهانه

            GetLog(MyRule, " Before Execute State:", 1011, 8, 3, 3034);
            int remain = this.Person.GetRemainLeave(this.RuleCalculateDate);
            if (this.DoConcept(3034).Value <= remain)
            {
                this.DoConcept(1011).Value += this.DoConcept(3034).Value;
                this.DoConcept(8).Value += this.DoConcept(3034).Value;
                this.DoConcept(3).Value += this.DoConcept(3034).Value;
                this.DoConcept(3034).Value = 0;
                this.Person.AddUsedLeave(this.RuleCalculateDate, this.DoConcept(3034).Value, null);
            }
            else
            {
                this.DoConcept(1011).Value += remain;
                this.DoConcept(8).Value += remain;
                this.DoConcept(3).Value += remain;
                this.DoConcept(3034).Value -= remain;
                this.Person.AddUsedLeave(this.RuleCalculateDate, remain, null);
            }
            GetLog(MyRule, " After Execute State:", 1011, 8, 3, 3034);
        }

        /// <summary>قانون متفرقه 2-2</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي چهار-4 درنظر گرفته شده است</remarks>
        public virtual void R4(AssignedRule MyRule)
        {
            GetLog(MyRule, " Before Execute State:", 2, 3028, 3004);
            PairableScndCnpValue.AppendPairsToScndCnpValue(this.DoConcept(3028),
                                                             this.DoConcept(2));
            this.DoConcept(3028).Value = 0;
            if (this.DoConcept(3004).Value > 0)
            {
                this.DoConcept(2).Value += this.DoConcept(6).Value;
                this.DoConcept(3004).Value = 0;
            }
            this.ReCalculate(13);

            GetLog(MyRule, " After Execute State:", 2, 3028, 3004);
        }

        /// <summary>قانون متفرقه 4-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي پنج-5 درنظر گرفته شده است</remarks>
        /// <!--اين قانون بايد بعد از تبديل غيبت هاي ساعتي به روزانه اجرا شود-->
        public virtual void R5(AssignedRule MyRule)
        {
            //3034 غيبت ساعتي ماهانه
            //4005 اضافه کارساعتي ماهانه
            //8 کارکردخالص ساعتي ماهانه
            GetLog(MyRule, " Before Execute State:", 3034, 4005, 8, 3006);
            if (this.DoConcept(4005).Value >= this.DoConcept(3034).Value)
            {
                this.DoConcept(4005).Value -= this.DoConcept(3034).Value;
                this.DoConcept(8).Value += this.DoConcept(3034).Value;
                this.DoConcept(3034).Value = 0;
            }
            else
            {
                this.DoConcept(8).Value += this.DoConcept(4005).Value;
                this.DoConcept(3034).Value -= this.DoConcept(4005).Value;
                this.DoConcept(4005).Value = 0;
            }
            GetLog(MyRule, " Before Execute State:", 3034, 4005, 8, 3006);
        }

        /// <summary>
        /// ترددها یک در میان ورود و خروج شود
        /// در ترافیک مپر استفاده میشود
        /// </summary>
        /// <param name="MyRule"></param>
        public virtual void R6(AssignedRule MyRule)
        {
        }

        /// <summary>قانون متفرقه 5-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي هفت-7 درنظر گرفته شده است</remarks>
        public virtual void R7(AssignedRule MyRule)
        {
            //کارکرد خالص 2
            //کارکرد ناخالص 13
            //3008  تاخير خالص ساعتي           
            //مدت تاخيرمجاز 44  
            //اضافه کارآخروقت 4007
            //3021 تاخیر ساعتی مجاز
            //3028 غيبت ساعتی غیرمجاز
            //80 اگر تاخیر یا تعجیل بیشتر از حد شد این قانون ها اجرا نشود
            //3029 تاخير  ساعتي غیر مجاز       
            //1082 مجموع انواع مرخصی ساعتی که حقوق تعلق میگیرد           


            GetLog(MyRule, " Before Execute State:", 4007, 3021, 2, 4002, 3028, 3029);
            this.DoConcept(1082);

            if (this.DoConcept(3029).Value <= MyRule["First", this.RuleCalculateDate].ToInt()
                || MyRule["NotApplyIfGreater", this.RuleCalculateDate].ToInt() == 0)
            {
                int tmp = Operation.Minimum(this.DoConcept(3029).Value,
                                            this.DoConcept(4007).Value, MyRule["First", this.RuleCalculateDate].ToInt());
                ((PairableScndCnpValue)this.DoConcept(3029)).DecreasePairFromLast(tmp);
                ((PairableScndCnpValue)this.DoConcept(3028)).DecreasePairFromLast(tmp);
                ((PairableScndCnpValue)this.DoConcept(4002)).DecreasePairFromLast(tmp);
                this.DoConcept(2).Value += tmp;
                this.ReCalculate(4007, 3021);
            }
            GetLog(MyRule, " After Execute State:", 4007, 3021, 2, 4002, 3028, 3029);
        }

        /// <summary>قانون متفرقه 5-2</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي هشت-8 درنظر گرفته شده است</remarks>
        public virtual void R8(AssignedRule MyRule)
        {
            //3010 تعجيل خالص ساعتي
            //اضافه کاراول وقت 4008
            //1082 مجموع انواع مرخصی ساعتی که حقوق تعلق میگیرد
            this.DoConcept(1082);
            GetLog(MyRule, " Before Execute State:", 3030, 4002, 2, 4008);

            if (this.DoConcept(3030).Value > this.DoConcept(3012).Value)
            {
                if (this.DoConcept(3030).Value <= MyRule["First", this.RuleCalculateDate].ToInt()
                    || MyRule["NotApplyIfGreater", this.RuleCalculateDate].ToInt() == 0)
                {
                    int tmp = Operation.Minimum(this.DoConcept(3030).Value,
                                                this.DoConcept(4008).Value, MyRule["First", this.RuleCalculateDate].ToInt());
                    ((PairableScndCnpValue)this.DoConcept(3030)).DecreasePairFromFirst(tmp);
                    ((PairableScndCnpValue)this.DoConcept(4002)).DecreasePairFromFirst(tmp);
                    this.DoConcept(2).Value += tmp;
                    this.ReCalculate(4008);
                }
            }

            GetLog(MyRule, " After Execute State:", 3030, 4002, 2, 4008);
        }

        /// <summary>قانون متفرقه 7-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي ده-10 درنظر گرفته شده است</remarks>
        public virtual void R10(AssignedRule MyRule)
        {
            //1003 مرخصی ساعتی
            //4013 اضافه کارساعتی جمعه
            GetLog(MyRule, " Before Execute State:", 1003);
            if (this.RuleCalculateDate.DayOfWeek == DayOfWeek.Friday)
            {
                this.DoConcept(1003).Value -= this.DoConcept(4013).Value;
                this.Person.AddRemainLeave(this.RuleCalculateDate, this.DoConcept(4013).Value);
            }
            GetLog(MyRule, " After Execute State:", 1003);
        }

        /// <summary>قانون متفرقه 7-2</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي يازده-11 درنظر گرفته شده است</remarks>
        public virtual void R11(AssignedRule MyRule)
        {
            //1003 مرخصی ساعتی
            //4002 اضافه کار ساعتی
            GetLog(MyRule, " Before Execute State:", 1003);
            if (!(this.RuleCalculateDate.DayOfWeek == DayOfWeek.Friday) &&
                (EngEnvironment.HasCalendar(this.RuleCalculateDate, "1", "2")) &&
                this.DoConcept(4002).Value > 0)
            {
                this.DoConcept(1003).Value -= this.DoConcept(4002).Value;
                this.Person.AddRemainLeave(this.RuleCalculateDate, this.DoConcept(4002).Value);
            }
            GetLog(MyRule, " After Execute State:", 1003);
        }

        /// <summary>قانون متفرقه 8-2</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي دوازده-12 درنظر گرفته شده است</remarks>
        /// <!--در صورتيکه منظور قانون غيبتهاي روزانه بوده بايد متن اين قانون تغيير کند-->
        public virtual void R12(AssignedRule MyRule)
        {
            throw new NotImplementedException("مشکل دارد");
            //غيبت روزانه ماهانه 3005
            //اضافه کار ساعتي ماهانه 4005
            //غیبت در روز 3019
            //8 کارکردخالص ساعتي ماهانه
            //5 کارکردخالص روزانه ماهانه
            GetLog(MyRule, " Before Execute State:", 3005, 5, 8, 4005);
            int t = this.DoConcept(3019).Value;
            if (this.DoConcept(4005).Value > 0 && this.DoConcept(3005).Value > 0 && t > 0)
            {
                int tmp = Operation.Minimum(this.DoConcept(4005).Value,
                                                this.DoConcept(3005).Value * t);
                this.DoConcept(3005).Value -= tmp;
                this.DoConcept(5).Value += tmp;
                this.DoConcept(8).Value += tmp;
                this.DoConcept(4005).Value -= tmp;
            }
            GetLog(MyRule, " After Execute State:", 3005, 5, 8, 4005);
        }

        /// <summary>قانون متفرقه 9-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي سيزده-13 درنظر گرفته شده است</remarks>
        public virtual void R13(AssignedRule MyRule)
        {
            //غيبت ساعتي 3001
            //اضافه کار ساعتي 56
            //3028 غيبت ساعتی غیرمجاز
            //4002 اضافه کارساعتي مجاز
            //2 کارکردخالص ساعتي
            //4017 اضافه کار مجاز کارتی
            ProceedTraffic proceedTraffic = this.Person.GetProceedTraficByDate(this.RuleCalculateDate);
            if (proceedTraffic.IsFilled)
            {
                GetLog(MyRule, " Before Execute State:", 3020, 3028, 4002, 4017, 2);
                if (this.DoConcept(4002).Value > 0 && this.DoConcept(3028).Value > 0)
                {
                    int tmp = Operation.Minimum(this.DoConcept(3028).Value,
                                                this.DoConcept(4002).Value,
                                                MyRule["First", this.RuleCalculateDate].ToInt());
                    ((PairableScndCnpValue)this.DoConcept(3028)).DecreasePairFromLast(tmp);
                    this.DoConcept(3020).Value += tmp;
                    ((PairableScndCnpValue)this.DoConcept(4002)).DecreasePairFromLast(tmp);
                    this.DoConcept(2).Value += tmp;
                }

                if (this.DoConcept(4017).Value > 0 && this.DoConcept(3028).Value > 0)
                {
                    int tmp = Operation.Minimum(this.DoConcept(3028).Value,
                                                this.DoConcept(4017).Value,
                                                MyRule["First", this.RuleCalculateDate].ToInt());
                    ((PairableScndCnpValue)this.DoConcept(3028)).DecreasePairFromLast(tmp);
                    this.DoConcept(3020).Value += tmp;
                    ((PairableScndCnpValue)this.DoConcept(4017)).DecreasePairFromLast(tmp);
                    this.DoConcept(2).Value += tmp;
                }
                GetLog(MyRule, " After Execute State:", 3020, 3028, 4002, 4017, 2);
            }
        }

        /// <summary>قانون متفرقه 9-2</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي چهارده-14 درنظر گرفته شده است</remarks>
        public virtual void R14(AssignedRule MyRule)
        {
            //3034 غیبت ساعتی غیرمجاز ماهانه
            //4005 اضافه کارساعتي مجاز ماهانه
            //8 کارکردخالص ساعتي ماهانه

            GetLog(MyRule, " Before Execute State:", 4005, 3034, 8);
            int tmp = Operation.Minimum(this.DoConcept(4005).Value, this.DoConcept(3034).Value, MyRule["First", this.RuleCalculateDate].ToInt());
            this.DoConcept(3034).Value -= tmp;
            this.DoConcept(4005).Value -= tmp;
            this.DoConcept(8).Value += tmp;
            GetLog(MyRule, " After Execute State:", 4005, 3034, 8);

        }

        /// <summary>متفرقه 10-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي تاخير-15 درنظر گرفته شده است</remarks>
        public virtual void R15(AssignedRule MyRule)
        {
            //تاخير ساعتي ماهانه 3009
            //مرخصي استحقاقي ساعتي ماهانه 1011
            //غيبت ساعتي ماهانه 3034
            GetLog(MyRule, " Before Execute State:", 3034, 3009, 1011);
            int tmp = Operation.Minimum(this.DoConcept(3009).Value,
                                         MyRule["First", this.RuleCalculateDate].ToInt(), this.Person.GetRemainLeave(this.RuleCalculateDate));

            if (tmp > 0)
            {
                this.DoConcept(3034).Value -= tmp;
                this.DoConcept(3009).Value -= tmp;
                this.DoConcept(1011).Value += tmp;
                this.Person.AddUsedLeave(this.RuleCalculateDate, tmp, null);
                if (this.DoConcept(3034).Value < 0)
                {
                    this.DoConcept(3034).Value = 0;
                }
            }

            GetLog(MyRule, " After Execute State:", 3034, 3009, 1011);
        }

        /// <summary>متفرقه 10-2</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي شانزده-16 درنظر گرفته شده است</remarks>
        public virtual void R16(AssignedRule MyRule)
        {
            //تعجيل ساعتي ماهانه 49
            //مرخصي استحقاقي ساعتي ماهانه 1011
            //غيبت ساعتي ماهانه 3006
            GetLog(MyRule, " Before Execute State:", 3034, 3010, 1011);
            int tmp = Operation.Minimum(this.DoConcept(3010).Value,
                                       MyRule["First", this.RuleCalculateDate].ToInt(), this.Person.GetRemainLeave(this.RuleCalculateDate));

            if (tmp > 0)
            {
                this.DoConcept(3034).Value -= tmp;
                this.DoConcept(3010).Value -= tmp;
                this.DoConcept(1011).Value += tmp;
                if (this.DoConcept(3034).Value < 0)
                {
                    this.DoConcept(3034).Value = 0;
                }
            }

            GetLog(MyRule, " After Execute State:", 3034, 3010, 1011);
        }

        /// <summary>متفرقه 14-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي هفده-17 درنظر گرفته شده است</remarks>
        public virtual void R17(AssignedRule MyRule)
        {
            //تقويم تعطيل رسمي 1
            //ایاب و ذهاب 5001
            GetLog(MyRule, " Before Execute State:", 5001);
            this.DoConcept(5001).Value = 0;
            if (MyRule["First", this.RuleCalculateDate].ToInt() == 1 && this.DoConcept(1).Value > 0)
            {
                this.DoConcept(5001).Value = 1;
            }
            if (MyRule["Second", this.RuleCalculateDate].ToInt() == 1 && EngEnvironment.HasCalendar(this.RuleCalculateDate, "1", "2"))
            {
                this.DoConcept(5001).Value = 1;
            }
            if (MyRule["Third", this.RuleCalculateDate].ToInt() == 1 && (this.DoConcept(2005).Value > 0 || this.DoConcept(2008).Value > 0))
            {
                this.DoConcept(5001).Value = 1;
            }
            else if (MyRule["Fourth", this.RuleCalculateDate].ToInt() == 1 && this.Person.GetProceedTraficByDate(this.RuleCalculateDate).PairCount > 0)
            {
                this.DoConcept(5001).Value = 1;
            }
            GetLog(MyRule, " After Execute State:", 5001);
        }

        /// <summary>متفرقه 15-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي هيجده-18 درنظر گرفته شده است</remarks>
        public virtual void R18(AssignedRule MyRule)
        {
            //تقويم تعطيل رسمي 1
            //حق غذا 5004
            GetLog(MyRule, " Before Execute State:", 5004);
            this.DoConcept(5004).Value = 0;
            if (MyRule["First", this.RuleCalculateDate].ToInt() == 1 && this.DoConcept(1).Value > 0)
            {
                this.DoConcept(5004).Value = 1;
            }
            if (MyRule["Second", this.RuleCalculateDate].ToInt() == 1 && EngEnvironment.HasCalendar(this.RuleCalculateDate, "1", "2"))
            {
                this.DoConcept(5004).Value = 1;
            }
            if (MyRule["Third", this.RuleCalculateDate].ToInt() == 1 && (this.DoConcept(2005).Value > 0 || this.DoConcept(2008).Value > 0))
            {
                this.DoConcept(5004).Value = 1;
            }
            else if (MyRule["Fourth", this.RuleCalculateDate].ToInt() == 1 && this.Person.GetProceedTraficByDate(this.RuleCalculateDate).PairCount > 0)
            {
                this.DoConcept(5004).Value = 1;
            }
            GetLog(MyRule, " After Execute State:", 5004);
        }

        /// <summary>متفرقه 16-3</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي نوزده-19 درنظر گرفته شده است</remarks>
        public virtual void R19(AssignedRule MyRule)
        {
            //16 شب کاري
            //کارکرد خالص شب 15
            //4012 اضافه کارساعتي مجازشب

            GetLog(MyRule, " Before Execute State:", 16);
            if (this.DoConcept(15).Value + this.DoConcept(4012).Value >= MyRule["First", this.RuleCalculateDate].ToInt())
            {
                this.DoConcept(16).Value = 1;
            }
            else
            {
                this.DoConcept(16).Value = 0;
            }
            GetLog(MyRule, " After Execute State:", 16);

        }

        /// <summary>اضافه کار بهمراه کارکرد ناخالص محاسبه نشود</summary>
        /// <remarks></remarks>
        public virtual void R20(AssignedRule MyRule)
        {
            //13  کارکرد ناخالص
            //اضافه کار 4002          

            GetLog(MyRule, " Before Execute State:", 4002, 13);
            this.DoConcept(13);
            ((PairableScndCnpValue)this.DoConcept(4002)).ClearPairs();
            GetLog(MyRule, " After Execute State:", 4002, 13);
        }

        /// <summary>قانون متفرقه 19-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي بيست و يک-21 درنظر گرفته شده است</remarks>
        public virtual void R21(AssignedRule MyRule)
        {
            //3031 غیبت بین وقت ساعتی غیرمجاز
            //3028 غیبت غیر مجاز ساعتی
            //2 کارکردخالص ساعتي
            GetLog(MyRule, " Before Execute State:", 3031, 3028, 2);
            int t = Operation.Intersect(this.DoConcept(3031), new PairableScndCnpValuePair(MyRule["First", this.RuleCalculateDate].ToInt(), (int)MyRule["Second", this.RuleCalculateDate].ToInt())).Value;
            int t4 = Operation.Minimum(t, MyRule["Third", this.RuleCalculateDate].ToInt());
            int t5 = t - t4;
            ((PairableScndCnpValue)this.DoConcept(3031)).DecreasePairFromLast(t4);
            this.DoConcept(2).Value += t4;
            this.DoConcept(3028).Value -= t4;
            GetLog(MyRule, " After Execute State:", 3031, 3028, 2);
        }

        /// <summary>1-20 قانون متفرقه</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي بيست و دو-22 درنظر گرفته شده است</remarks>
        public virtual void R22(AssignedRule MyRule)
        {
            //21 حضور ویژه
            GetLog(MyRule, " Before Execute State:", 21);
            ((PairableScndCnpValue)this.DoConcept(21)).AddPairs(Operation.Intersect(this.DoConcept(1), new PairableScndCnpValuePair(MyRule["First", this.RuleCalculateDate].ToInt(), MyRule["Second", this.RuleCalculateDate].ToInt())));
            GetLog(MyRule, " After Execute State:", 21);
        }

        /// <summary>1-21 قانون متفرقه</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي یکصدو ده-110 درنظر گرفته شده است</remarks>
        public virtual void R110(AssignedRule MyRule)
        {
            //4002 اضافه کارمجاز ساعتي
            //4003 اضافه کاری غیر مجاز
            GetLog(MyRule, " Before Execute State:", 4002, 4003);

            ((PairableScndCnpValue)this.DoConcept(4003))
                                            .AddPairs(Operation.Intersect(this.DoConcept(4002),
                                                        new PairableScndCnpValuePair(MyRule["First", this.RuleCalculateDate].ToInt(), MyRule["Second", this.RuleCalculateDate].ToInt())));
            ((PairableScndCnpValue)this.DoConcept(4002))
                                            .AddPairs(Operation.Differance(this.DoConcept(4002),
                                                        new PairableScndCnpValuePair(MyRule["First", this.RuleCalculateDate].ToInt(), MyRule["Second", this.RuleCalculateDate].ToInt())));

            GetLog(MyRule, " After Execute State:", 4002, 4003);
        }

        /// <summary>1-22 قانون متفرقه</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي یکصدو یازده -111 درنظر گرفته شده است</remarks>
        public virtual void R111(AssignedRule MyRule)
        {
            //4002 اضافه کارمجاز ساعتي
            //4003 اضافه کاری غیر مجاز
            GetLog(MyRule, " Before Execute State:", 4002, 4003);

            ((PairableScndCnpValue)this.DoConcept(4003))
                                            .AddPairs(Operation.Intersect(this.DoConcept(4002),
                                                        new PairableScndCnpValuePair(MyRule["First", this.RuleCalculateDate].ToInt(), MyRule["Second", this.RuleCalculateDate].ToInt())));
            ((PairableScndCnpValue)this.DoConcept(4002))
                                            .AddPairs(Operation.Differance(this.DoConcept(4002),
                                                        new PairableScndCnpValuePair(MyRule["First", this.RuleCalculateDate].ToInt(), MyRule["Second", this.RuleCalculateDate].ToInt())));

            GetLog(MyRule, " After Execute State:", 4002, 4003);

        }

        /// <summary>1-23 قانون متفرقه</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي یکصدو یازده -112 درنظر گرفته شده است</remarks>
        public virtual void R112(AssignedRule MyRule)
        {
            //4002 اضافه کارمجاز ساعتي
            //4003 اضافه کاری غیر مجاز
            GetLog(MyRule, " Before Execute State:", 4002, 4003);

            ((PairableScndCnpValue)this.DoConcept(4003))
                                            .AddPairs(Operation.Intersect(this.DoConcept(4002),
                                                        new PairableScndCnpValuePair(MyRule["First", this.RuleCalculateDate].ToInt(), MyRule["Second", this.RuleCalculateDate].ToInt())));
            ((PairableScndCnpValue)this.DoConcept(4002))
                                            .AddPairs(Operation.Differance(this.DoConcept(4002),
                                                        new PairableScndCnpValuePair(MyRule["First", this.RuleCalculateDate].ToInt(), MyRule["Second", this.RuleCalculateDate].ToInt())));

            GetLog(MyRule, " After Execute State:", 4002, 4003);
        }

        /// <summary>1-24 قانون متفرقه</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي یکصدو یازده -113 درنظر گرفته شده است</remarks>
        public virtual void R113(AssignedRule MyRule)
        {
            //4002 اضافه کارمجاز ساعتي
            //4003 اضافه کاری غیر مجاز
            GetLog(MyRule, " Before Execute State:", 4002, 4003);

            ((PairableScndCnpValue)this.DoConcept(4003))
                                            .AddPairs(Operation.Intersect(this.DoConcept(4002),
                                                        new PairableScndCnpValuePair(MyRule["First", this.RuleCalculateDate].ToInt(), MyRule["Second", this.RuleCalculateDate].ToInt())));
            ((PairableScndCnpValue)this.DoConcept(4002))
                                            .AddPairs(Operation.Differance(this.DoConcept(4002),
                                                        new PairableScndCnpValuePair(MyRule["First", this.RuleCalculateDate].ToInt(), MyRule["Second", this.RuleCalculateDate].ToInt())));

            GetLog(MyRule, " After Execute State:", 4002, 4003);
        }

        /// <summary>متفرقه 25-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي بيست و سه-23 درنظر گرفته شده است</remarks>
        public virtual void R23(AssignedRule MyRule)
        {
            //71 جمعه کاري
            //2 کارکردخالص ساعتي
            //6 کارکرد لازم
            GetLog(MyRule, " Before Execute State:", 5003);

            if (this.RuleCalculateDate.DayOfWeek == DayOfWeek.Friday)
            {
                if (this.DoConcept(6).Value > 0)
                {
                    if (MyRule["Second", this.RuleCalculateDate].ToInt() == 1)
                    {
                        if (this.DoConcept(2).Value < MyRule["First", this.RuleCalculateDate].ToInt())
                        {
                            this.DoConcept(5003).Value += this.DoConcept(2).Value;
                        }
                        else
                        {
                            this.DoConcept(5003).Value += MyRule["First", this.RuleCalculateDate].ToInt();
                        }
                    }
                    else
                    {
                        if (this.DoConcept(13).Value < MyRule["First", this.RuleCalculateDate].ToInt())
                        {
                            this.DoConcept(5003).Value += this.DoConcept(13).Value;
                        }
                    }
                    this.DoConcept(5003).Value += 1;
                }
                else
                {
                    if (MyRule["Third", this.RuleCalculateDate].ToInt() == 1)
                    {
                        if (this.DoConcept(13).Value < MyRule["First", this.RuleCalculateDate].ToInt())
                        {
                            this.DoConcept(5003).Value += this.DoConcept(13).Value;
                        }
                        else
                        {
                            this.DoConcept(5003).Value = MyRule["First", this.RuleCalculateDate].ToInt();
                        }
                    }
                    else if (this.DoConcept(13).Value > MyRule["First", this.RuleCalculateDate].ToInt())
                    {
                        this.DoConcept(5003).Value += this.DoConcept(13).Value - MyRule["First", this.RuleCalculateDate].ToInt();
                    }
                }
            }
            GetLog(MyRule, " After Execute State:", 5003);
        }

        /// <summary>
        /// پایان شبانه روز
        /// </summary>
        /// <param name="MyRule"></param>
        public virtual void R24(AssignedRule MyRule)
        {
            //5018 پایان شبانه روز
            GetLog(MyRule, " Before Execute State:", 5018);
            this.DoConcept(5018).Value = MyRule["First"].ToInt();
            GetLog(MyRule, " After Execute State:", 5018);
        }

        /// <summary></summary>
        /// <remarks>تردد اتوماتیک داخل شیفت</remarks>
        public virtual void R25(AssignedRule MyRule)
        {
            //Apply on Traffic Mapper
        }

        /// <summary>قانون متفرقه- مقداردهی به روز ناهاری
        /// </summary>
        public virtual void R282(AssignedRule MyRule)
        {
            //5014 کارکرد لازم برای حق غذا
            //5015 حق غذا ماهانه
            //2023 مجموع ماموريت ساعتي
            //1 حضور

            if (this.Person.GetShiftByDate(this.RuleCalculateDate).Value > 0)
            {
                GetLog(MyRule, " Before Execute State:", 5014);

                if (this.DoConcept(1).Value + this.DoConcept(2023).Value >= MyRule["First", this.RuleCalculateDate].ToInt())
                {
                    DoConcept(5014).Value = 1;
                    this.ReCalculate(5015);
                }

                GetLog(MyRule, " After Execute State:", 5014);
            }
        }

        #endregion

        #region قوانين کارکرد

        /// <summary>قانون مقداردهی C14</summary>        
        public virtual void R221(AssignedRule MyRule)
        {
            PairableScndCnpValue.AppendPairToScndCnpValue(new PairableScndCnpValuePair(MyRule["First", this.RuleCalculateDate].ToInt(), MyRule["Second", this.RuleCalculateDate].ToInt()), this.DoConcept(14));

            this.DoConcept(16).Value = 1;

            this.DoConcept(15);

        }

        /// <summary>قانون مقداردهی C16</summary>        
        public virtual void R222(AssignedRule MyRule)
        {
            throw new Exception("بوسیله قانون 221 فعال می گردد");

            this.DoConcept(16).Value = MyRule["First", this.RuleCalculateDate].ToInt();
        }



        /// <summary>قانون کارکرد 2-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي بيست و شش-26 درنظر گرفته شده است</remarks>
        public virtual void R26(AssignedRule MyRule)
        {
            throw new Exception("بوسیه پارامتر در قوانین 203 اعمال گردید");

            //25 روزهای غیر کاری جزو کارکرد حساب شود
            GetLog(MyRule, " After Execute State:", 25);
            this.DoConcept(25).Value = 1;
            GetLog(MyRule, " After Execute State:", 25);
        }

        /// <summary>قانون کارکرد 3-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي بيست و شش-27 درنظر گرفته شده است</remarks>
        public virtual void R27(AssignedRule MyRule)
        {
            //3004 غيبت روزانه
            //7 کارکرددرروز
            //2 کارکردخالص ساعتي 
            //کارکردخالص روزانه 4

            if (this.DoConcept(3004).Value == 0 &&
                this.DoConcept(2).Value > 0 &&
                this.Person.GetShiftByDate(this.RuleCalculateDate).Value == this.DoConcept(7).Value &&
                this.Person.GetShiftByDate(this.RuleCalculateDate).ShiftType != ShiftTypesEnum.OVERTIME)
            {
                GetLog(MyRule, " Before Execute State:", 4);
                this.DoConcept(4).Value = 1;
                GetLog(MyRule, " After Execute State:", 4);
            }
        }

        /// <summary>قانون کارکرد 4-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي بيست و هشت-28 درنظر گرفته شده است</remarks>
        /// کارکرد 4-1: روزهاي کاري بيشتر از (ساعت کارکرد در روز) يک روز کاري حساب شود
        public virtual void R28(AssignedRule MyRule)
        {
            //6 کارکردلازم
            //7 کارکرددرروز
            //4 کارکردخالص روزانه
            //3004 غيبت روزانه
            //2023 مجموع ماموریت ساعتی
            //1082 مجموع انواع مرخصی ساعتی
            GetLog(MyRule, " Before Execute State:", 4);

            // به مرخصی بی حقوق , کارکرد روزانه و بیمه تعلق نمیگیرد
            if (this.DoConcept(6).Value > 0 && this.DoConcept(1091).Value == 0)
            {
                this.DoConcept(2023);
                this.DoConcept(1082);
                //غیبت روزانه نداشت و همه روز غیبت نداشت
                //قانونی که غیبت ساعتی را به روزانه تبدیل میکند اولویت پایین تری دارد
                if (this.DoConcept(3004).Value == 0
                    &&
                    Operation.Differance(this.Person.GetShiftByDate(this.RuleCalculateDate), this.DoConcept(3028)).Value > 0)
                {
                    this.DoConcept(4).Value = 1;
                }
            }
            GetLog(MyRule, " After Execute State:", 4);
        }

        /// <summary>قانون کارکرد 5-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي بيست و نه-29 درنظر گرفته شده است</remarks>
        /// کارکرد 5-1: روزهاي کاري کمتر از (ساعت کارکرد در روز) يک روز کاري حساب شود
        public virtual void R29(AssignedRule MyRule)
        {
            GetLog(MyRule, " Before Execute State:", 4);
            if (this.DoConcept(6).Value > 0)
            {
                if (this.DoConcept(1).Value > 0)
                {
                    if (this.DoConcept(6).Value <= this.DoConcept(7).Value)
                    {
                        this.DoConcept(4).Value = 0;
                        if (this.DoConcept(3004).Value == 0)
                        {
                            this.DoConcept(4).Value = 1;
                        }
                    }
                }
                else
                {
                    if (this.DoConcept(6).Value < this.DoConcept(7).Value && this.DoConcept(2).Value > 0)
                    {
                        this.DoConcept(4).Value = 1;
                    }
                }
            }
            GetLog(MyRule, " Before Execute State:", 4);
        }

        /// <summary>قانون کارکرد 4-2روزهاي کاري بیشتر از (ساعت کارکرد در روز) به تناسب روز کاری حساب شود</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي سي-30 درنظر گرفته شده است</remarks>
        public virtual void R30(AssignedRule MyRule)
        {
            //6 کارکردلازم
            //7 کارکرددرروز
            //4 کارکردخالص روزانه
            //3004 غيبت روزانه

            GetLog(MyRule, " Before Execute State:", 4);
            if (this.DoConcept(7).Value == 0)
            {
                this.DoConcept(4).Value = 0;
            }
            else
            {
                this.DoConcept(4).Value = this.DoConcept(6).Value / this.DoConcept(7).Value;
            }
            GetLog(MyRule, " After Execute State:", 4);
        }

        /// <summary>قانون کارکرد 7-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي سي و يک-31 درنظر گرفته شده است</remarks>
        public virtual void R31(AssignedRule MyRule)
        {
            throw new NotImplementedException("به فلوچارت مربوطه مراجعه شود-این قانون جز قوانین منسوخ میباشد");
        }

        /// <summary>قانون کارکرد 8-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي سي و دو-32 درنظر گرفته شده است</remarks>
        public virtual void R32(AssignedRule MyRule)
        {
            //11 مفهوم تعداد روز
            //کارکردلازم ماهانه 10
            //کارکردخالص ساعتي ماهانه 8
            //3 کارکردناخالص ماهانه

            //غیبت ساعتی مجاز ماهانه 3026
            //3034 غیبت ساعتی غیرمجاز ماهانه
            //3005 غيبت خالص روزانه ماهانه

            //4005 اضافه کارساعتي مجاز ماهانه
            //4006 اضافه کارساعتي غیرمجاز ماهانه
            //4018  حداکثر اضافه کار مجاز ماهانه

            //9 حضورماهانه           
            GetLog(MyRule, " Before Execute State:", 3034, 4005, 8, 3, 4006);
            int t2 = MyRule[this.RuleCalculateDate.Month.ToString() + "th", this.RuleCalculateDate].ToInt() * HourMin;

            if (t2 > this.DoConcept(8).Value)
            {
                int tmp = t2 - this.DoConcept(10).Value;
                if (this.DoConcept(4005).Value > tmp)
                {
                    this.DoConcept(4005).Value -= tmp;
                    this.DoConcept(8).Value += tmp;
                }
                else
                {
                    this.DoConcept(8).Value += this.DoConcept(4005).Value;
                    this.DoConcept(3034).Value += tmp - this.DoConcept(4005).Value;
                    this.DoConcept(4005).Value = 0;
                }

            }
            else
            {
                if (this.DoConcept(8).Value > t2)
                {
                    this.DoConcept(3034).Value -= this.DoConcept(10).Value + this.DoConcept(8).Value;
                    if (this.DoConcept(3034).Value < 0)
                    {
                        this.DoConcept(3034).Value = 0;
                    }
                    this.DoConcept(4005).Value += this.DoConcept(8).Value - t2;
                    this.DoConcept(8).Value = t2;
                }
                else
                {
                    this.DoConcept(3034).Value -= this.DoConcept(10).Value + t2;
                    if (this.DoConcept(3034).Value < 0)
                    {
                        this.DoConcept(3034).Value = 0;
                    }
                    if (this.DoConcept(4005).Value > this.DoConcept(9).Value)
                    {
                        this.DoConcept(4005).Value = this.DoConcept(9).Value;
                    }
                }
            }
            if (this.DoConcept(4005).Value > this.DoConcept(4018).Value * HourMin)
            {
                this.DoConcept(3).Value -= this.DoConcept(4005).Value + this.DoConcept(4018).Value * HourMin;
                this.DoConcept(4006).Value += this.DoConcept(4005).Value - this.DoConcept(4018).Value * HourMin;
                this.DoConcept(4005).Value = this.DoConcept(4018).Value * HourMin;
            }
            GetLog(MyRule, " Before Execute State:", 3034, 4005, 8, 3, 4006);
        }

        /// <summary>قانون کارکرد 8-2</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي سي و سه-33 درنظر گرفته شده است</remarks>
        public virtual void R33(AssignedRule MyRule)
        {
            //3 کارکردناخالص ماهانه
            //6 کارکرد لازم
            //کارکردخالص ساعتي ماهانه 8
            //9 حضور ماهانه
            //کارکردلازم ماهانه 10
            //3034 غیبت ساعتی غیرمجاز ماهانه
            //4005 اضافه کارساعتي مجاز ماهانه
            //4006 اضافه کارساعتي غیرمجاز ماهانه
            //4010 اضافه کارساعتي تعطيل ماهانه

            //1006 مرخصي استحقاقي روزانه ماهانه
            //1011 مرخصي استحقاقي ساعتي ماهانه
            //1017 مرخصي استعلاجي روزانه ماهانه
            //1097 ممرخصی با حقوق ماهانه
            if (this.DoConcept(10).Value > 0)
            {
                GetLog(MyRule, " Before Execute State:", 8, 10, 3034, 4005, 4006, 4010);

                int lazem = 8 * 60;
                //پیدا کردن کارکرد لازم برای مرخصی
                for (int i = 0; i < 10; i++)
                {
                    if (this.DoConcept(6, this.RuleCalculateDate.AddDays(-1 * i)).Value > 0)
                    {
                        lazem = this.DoConcept(6, this.RuleCalculateDate.AddDays(-1 * i)).Value;
                        break;
                    }
                }

                int karkerd = this.DoConcept(9).Value + this.DoConcept(1006).Value * lazem
                                                      + this.DoConcept(1017).Value * lazem
                                                      + this.DoConcept(1097).Value * lazem
                                                      + this.DoConcept(1011).Value;

                int monthlyLazem = MyRule[this.RuleCalculateDate.Month.ToString() + "th", this.RuleCalculateDate].ToInt();
                this.DoConcept(10).Value = monthlyLazem * HourMin;
                if (this.DoConcept(8).Value >= monthlyLazem * HourMin)
                {
                    this.DoConcept(8).Value = monthlyLazem * HourMin;
                    this.DoConcept(4005).Value = karkerd - this.DoConcept(10).Value;
                    this.DoConcept(4006).Value = 0;
                    this.DoConcept(3034).Value = 0;
                }
                else
                {
                    this.DoConcept(3034).Value = this.DoConcept(10).Value - karkerd;
                    this.DoConcept(4005).Value = 0;
                    this.DoConcept(4006).Value = 0;
                    this.DoConcept(4010).Value = 0;
                }
                GetLog(MyRule, " After Execute State:", 8, 10, 3034, 4005, 4006, 4010);
            }

            this.DoConcept(3020).Value = 0;
            this.DoConcept(3028).Value = 0;
            this.DoConcept(4002).Value = 0;
            this.DoConcept(4003).Value = 0;
        }

        /// <summary>قانون کارکرد 8-3</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي سي و چهار-34 درنظر گرفته شده است</remarks>
        public virtual void R34(AssignedRule MyRule)
        {
            //11 مفهوم تعداد روز
            //کارکردلازم ماهانه 10
            //کارکردخالص ساعتي ماهانه 8
            //3 کارکردناخالص ماهانه

            //غیبت ساعتی مجاز ماهانه 3026
            //3034 غیبت ساعتی غیرمجاز ماهانه
            //3005 غيبت خالص روزانه ماهانه

            //4005 اضافه کارساعتي مجاز ماهانه
            //4006 اضافه کارساعتي غیرمجاز ماهانه
            //4018  حداکثر اضافه کار مجاز ماهانه

            //9 حضورماهانه

            GetLog(MyRule, " Before Execute State:", 8, 3034, 4005, 3);
            int t2 = MyRule["First", this.RuleCalculateDate].ToInt() * HourMin;

            if (t2 > this.DoConcept(8).Value)
            {
                int tmp = t2 - this.DoConcept(10).Value;
                if (this.DoConcept(4005).Value > tmp)
                {
                    this.DoConcept(4005).Value -= tmp;
                    this.DoConcept(8).Value += tmp;
                }
                else
                {
                    this.DoConcept(8).Value += this.DoConcept(4005).Value;
                    this.DoConcept(3034).Value += tmp - this.DoConcept(4005).Value;
                    this.DoConcept(4005).Value = 0;
                }

            }
            else
            {
                if (this.DoConcept(8).Value > t2)
                {
                    this.DoConcept(3034).Value -= this.DoConcept(10).Value + this.DoConcept(8).Value;
                    if (this.DoConcept(3034).Value < 0)
                    {
                        this.DoConcept(3034).Value = 0;
                    }
                    this.DoConcept(4005).Value += this.DoConcept(8).Value - t2;
                    this.DoConcept(8).Value = t2;
                }
                else
                {
                    this.DoConcept(3034).Value -= this.DoConcept(10).Value + t2;
                    if (this.DoConcept(3034).Value < 0)
                    {
                        this.DoConcept(3034).Value = 0;
                    }
                    if (this.DoConcept(4005).Value > this.DoConcept(9).Value)
                    {
                        this.DoConcept(4005).Value = this.DoConcept(9).Value;
                    }
                }
            }
            if (this.DoConcept(4005).Value > this.DoConcept(4018).Value * HourMin)
            {
                this.DoConcept(3).Value -= this.DoConcept(4005).Value + this.DoConcept(4018).Value * HourMin;
                this.DoConcept(4006).Value += this.DoConcept(4005).Value - this.DoConcept(4018).Value * HourMin;
                this.DoConcept(4005).Value = this.DoConcept(4018).Value * HourMin;
            }
            GetLog(MyRule, " After Execute State:", 8, 3034, 4005, 3);
        }

        /// <summary>قانون کارکرد 8-4</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي سي و پنج-35 درنظر گرفته شده است</remarks>
        public virtual void R35(AssignedRule MyRule)
        {
            //11 مفهوم تعداد روز
            //کارکردلازم ماهانه 10
            //کارکردخالص ساعتي ماهانه 8
            //3 کارکردناخالص ماهانه

            //غیبت ساعتی مجاز ماهانه 3026
            //3034 غیبت ساعتی غیرمجاز ماهانه
            //3005 غيبت خالص روزانه ماهانه

            //4005 اضافه کارساعتي مجاز ماهانه
            //4006 اضافه کارساعتي غیرمجاز ماهانه
            //4018  حداکثر اضافه کار مجاز ماهانه
            GetLog(MyRule, " Before Execute State:", 8, 3034, 4005, 3);
            int t2 = MyRule["First", this.RuleCalculateDate].ToInt() * this.DoConcept(11).Value;
            if (t2 > this.DoConcept(10).Value)
            {
                int temp = t2 - this.DoConcept(10).Value;
                if (this.DoConcept(4005).Value > temp)
                {
                    this.DoConcept(4005).Value -= temp;
                    this.DoConcept(8).Value += temp;
                }
                else
                {
                    this.DoConcept(8).Value += this.DoConcept(4005).Value;
                    this.DoConcept(3034).Value += temp - this.DoConcept(4005).Value;
                    this.DoConcept(4005).Value = 0;
                }
            }
            else
            {
                this.DoConcept(4005).Value += this.DoConcept(10).Value - t2;

                if (this.DoConcept(8).Value > t2)
                {
                    this.DoConcept(8).Value = t2;
                }
            }
            this.DoConcept(10).Value = t2;
            if (this.DoConcept(4005).Value > this.DoConcept(4018).Value * HourMin)
            {
                this.DoConcept(3).Value -= this.DoConcept(3).Value + this.DoConcept(4018).Value * HourMin;
                this.DoConcept(4006).Value += this.DoConcept(4005).Value - this.DoConcept(4018).Value * HourMin;
                this.DoConcept(4005).Value = this.DoConcept(4018).Value * HourMin;
            }
            GetLog(MyRule, " After Execute State:", 8, 3034, 4005, 3);
        }

        /// <summary>قانون کارکرد 8-5</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي سي و شش-36 درنظر گرفته شده است</remarks>
        public virtual void R36(AssignedRule MyRule)
        {
            //کارکردلازم ماهانه 10
            //کارکردخالص ساعتي ماهانه 8
            //3 کارکردناخالص ماهانه

            //غیبت ساعتی مجاز ماهانه 3026
            //3034 غیبت ساعتی غیرمجاز ماهانه
            //3005 غيبت خالص روزانه ماهانه

            //4005 اضافه کارساعتي مجاز ماهانه
            //4006 اضافه کارساعتي غیرمجاز ماهانه
            //4018 مفهوم حداکثر اضافه کار مجاز ماهانه

            //4010 اضافه کارساعتي تعطيل ماهانه
            //4019 مفهوم اضافه کار قبل از وقت ماهانه
            //4020 مفهوم اضافه کار بین وقت ماهانه
            //4021 مفهوم اضافه کار بعد از وقت ماهانه
            //625 مفهوم اضافه کار روز غیر کاری ماهانه
            //626 مفهوم اضافه کارساعتی جمعه ماهانه
            //627 مفهوم اضافه کارساعتی غیر مجاز جمعه ماهانه
            //628 مفهوم اضافه کارساعتی مجازتعطیل غیرجمعه ماهانه
            //629 مفهوم اضافه کارساعتی غیر مجازتعطیل غیرجمعه ماهانه

            //استفاده از انباره در اینجا بررسی شود
            throw new NotImplementedException();
            /*
            GetLog(MyRule, " Before Execute State:", 4010, 3005, 8, 3034, 4005, 4006, 625, 626, 627, 628, 629);
            IPersonWorkGroupRepository workGroupRep = PersonWorkGroup.GetPersonWorkGroupRepository(false);
            IList<PersonWorkGroup> list = workGroupRep.GetAll();
            int lazem = 0;
            if (list.Count > 0 && list.Where(x => x.WorkGroupID == MyRule["Second", this.RuleCalculateDate].ToInt()).Count() > 0)
            {
                lazem = list.Where(x => x.WorkGroupID == MyRule["Second", this.RuleCalculateDate].ToInt()).First().BaseShiftList
                    .Where(x => x.Date >= this.CalcDateZone.FromDate && x.Date <= this.CalcDateZone.ToDate)
                    .Sum(x => x.PairValues);
            }
            //            if (lazem != null)
            {
                this.DoConcept(10).Value = lazem;
                if (this.DoConcept(3).Value > lazem)
                {
                    this.DoConcept(8).Value = lazem;
                    this.DoConcept(4005).Value = this.DoConcept(3).Value - lazem;
                    this.DoConcept(3034).Value = 0;
                    this.DoConcept(3005).Value = 0;
                    this.DoConcept(4006).Value = 0;
                }
                else
                {
                    this.DoConcept(3034).Value = lazem - this.DoConcept(10).Value;
                    this.DoConcept(3005).Value = 0;
                    this.DoConcept(4005).Value = 0;
                    this.DoConcept(4006).Value = 0;
                    this.DoConcept(4010).Value = 0;

                    this.DoConcept(4006).Value = 0;

                }
                if (this.DoConcept(4005).Value > this.DoConcept(4018).Value * HourMin)
                {
                    this.DoConcept(3).Value -= (this.DoConcept(4005).Value + this.DoConcept(4018).Value * HourMin);
                    this.DoConcept(4006).Value += (this.DoConcept(4005).Value - this.DoConcept(4018).Value * HourMin);
                    this.DoConcept(4005).Value = this.DoConcept(4018).Value * HourMin;
                }

            }
            GetLog(MyRule, " After Execute State:", 4010, 3005, 8, 3034, 4005, 4006, 625, 626, 627, 628, 629);
             * */
        }

        /// <summary>قانون کارکرد 8-6</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي دویست و هشتاد-280 درنظر گرفته شده است</remarks>
        /// توسط این قانون تمامی قوانین محاسبه غیبت ماهانه، اضافه کار ماهانه نادیده
        /// گرفته شده و با توجه به پارامتر ورودی غیبت ماهانه و اضافه کارماهانه محاسبه می گردد
        public virtual void R280(AssignedRule MyRule)
        {
            //کارکردلازم ماهانه 10
            //کارکردخالص ساعتي ماهانه 8
            //3 کارکردناخالص ماهانه

            //غیبت ساعتی مجاز ماهانه 3026
            //3034 غیبت ساعتی غیرمجاز ماهانه
            //3005 غيبت خالص روزانه ماهانه

            //4005 اضافه کارساعتي مجاز ماهانه
            //4006 اضافه کارساعتي غیرمجاز ماهانه

            //4010 اضافه کارساعتي تعطيل ماهانه
            //4019 مفهوم اضافه کار قبل از وقت ماهانه
            //4020 مفهوم اضافه کار بین وقت ماهانه
            //4021 مفهوم اضافه کار بعد از وقت ماهانه
            //625 مفهوم اضافه کار روز غیر کاری ماهانه
            //626 مفهوم اضافه کارساعتی جمعه ماهانه
            //627 مفهوم اضافه کارساعتی غیر مجاز جمعه ماهانه
            //628 مفهوم اضافه کارساعتی مجازتعطیل غیرجمعه ماهانه
            //629 مفهوم اضافه کارساعتی غیر مجازتعطیل غیرجمعه ماهانه
            GetLog(MyRule, " Before Execute State:", 3, 4010, 3005, 8, 3034, 4005, 4006);
            this.DoConcept(10).Value = MyRule["First", this.RuleCalculateDate].ToInt() * HourMin;
            this.DoConcept(13);
            this.ReCalculate(3);
            if (this.DoConcept(3).Value >= (MyRule["First", this.RuleCalculateDate].ToInt() * HourMin))
            {
                this.DoConcept(8).Value = MyRule["First", this.RuleCalculateDate].ToInt() * HourMin;
                this.DoConcept(4005).Value = this.DoConcept(3).Value - (MyRule["First", this.RuleCalculateDate].ToInt() * HourMin);
                this.DoConcept(4006).Value = 0;
                this.DoConcept(3034).Value = 0;
                this.DoConcept(3005).Value = 0;
            }
            else
            {
                this.DoConcept(8).Value = this.DoConcept(3).Value;
                this.DoConcept(3034).Value = (MyRule["First", this.RuleCalculateDate].ToInt() * HourMin) - this.DoConcept(3).Value;
                this.DoConcept(3005).Value = 0;
                this.DoConcept(4005).Value = 0;
                this.DoConcept(4006).Value = 0;
                this.DoConcept(4010).Value = 0;

            }

            GetLog(MyRule, " After Execute State:", 3, 4010, 3005, 8, 3034, 4005, 4006);
        }

        /// <summary>قانون کارکرد 8-7</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي دویست و هشتاد و یک-280 درنظر گرفته شده است</remarks>
        public virtual void R281(AssignedRule MyRule)
        {
            //کارکردخالص ساعتي ماهانه 8
            //حضورماهانه 9
            //10 کارکردلازم ماهانه
            //3 کارکردناخالص ماهانه
            //3034 غیبت ساعتی غیرمجاز ماهانه
            //3005 غيبت خالص روزانه ماهانه
            //3020 غیبت ساعتی مجاز ماهانه
            //4005 اضافه کارساعتي مجاز ماهانه

            //4010 اضافه کارساعتي تعطيل ماهانه
            //4019 مفهوم اضافه کار قبل از وقت ماهانه
            //4020 مفهوم اضافه کار بین وقت ماهانه
            //4021 مفهوم اضافه کار بعد از وقت ماهانه
            //625 مفهوم اضافه کار روز غیر کاری ماهانه
            //626 مفهوم اضافه کارساعتی جمعه ماهانه
            //627 مفهوم اضافه کارساعتی غیر مجاز جمعه ماهانه
            //628 مفهوم اضافه کارساعتی مجازتعطیل غیرجمعه ماهانه
            //629 مفهوم اضافه کارساعتی غیر مجازتعطیل غیرجمعه ماهانه
            GetLog(MyRule, " Before Execute State:", 4010, 3005, 8, 3034, 4005, 10, 4019, 4020, 4021);
            this.DoConcept(8).Value = this.DoConcept(3).Value;
            this.DoConcept(10).Value = 0;
            this.DoConcept(3034).Value = 0;
            this.DoConcept(3005).Value = 0;
            this.DoConcept(4005).Value = 0;
            this.DoConcept(4019).Value = 0;
            this.DoConcept(4020).Value = 0;
            this.DoConcept(4021).Value = 0;
            this.DoConcept(4010).Value = 0;


            GetLog(MyRule, " After Execute State:", 4010, 3005, 8, 3034, 4005, 10, 4019, 4020, 4021);
        }

        /// <summary>
        /// حد اکثر سقف کارکرد در ماه - پرسنل ساعتی
        /// </summary>
        /// <param name="MyRule"></param>
        public virtual void R102(AssignedRule MyRule)
        {
            //3 کارکردناخالص ماهانه
            //4005 اضافه کار غیر مجاز ماهانه
            GetLog(MyRule, " Before Execute State:", 3, 4005);
            int maxTime = MyRule["First", this.RuleCalculateDate].ToInt();
            this.DoConcept(13);
            if (this.DoConcept(3).Value > maxTime)
            {
                this.DoConcept(4005).Value = this.DoConcept(3).Value - maxTime;
                this.DoConcept(3).Value = maxTime;
            }


            GetLog(MyRule, " After Execute State:", 3, 4005);
        }


        #endregion

        #region قوانين مرخصي

        /// <summary>قانون مرخصي 1-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي سي و هفت-3002 درنظر گرفته شده است</remarks>
        public virtual void R37(AssignedRule MyRule)
        {
            //مرخصي درروز 1001

            //1006 مفهوم مرخصي استحقاقي روزانه ماهانه
            //1011 مفهوم مرخصي استحقاقي ساعتي ماهانه

            //1016 مرخصی استعلاجی ساعتی ماهانه
            //1017 مرخصی استعلاجی روزانه ماهانه

            //1073 مرخصی بی حقوق ساعتی ماهانه_11
            //1074 مرخصی بی حقوق ساعتی ماهانه_11
            //1074 مرخصی بی حقوق ساعتی ماهانه
            //1076 مرخصی بی حقوق روزانه ماهانه

            //1043,1044,1045,1046,1047 مرخصی باحقوق ساعتی ماهیانه
            //1048,1049,1050,1051,1052 مرخصی باحقوق روزانه ماهیانه
            GetLog(MyRule, " Before Execute State:", 1006, 1011, 1017, 1016, 1074, 1073, 1076, 1074, 1043, 1044, 1045, 1046, 1047, 1048, 1049, 1050, 1051, 1052);

            if (this.DoConcept(1001).Value > 0)
            {

                // شرط اضافه شد
                // در صورتیکه مفاهیم هر روز مقدار داشته باشد و در پایان دوره
                // با مفهوم ماهانه صفر شوند برای نمایش روزانه ها این شرط اضافه شده
                if (this.DoConcept(1011).Value > 0)
                {
                    //استحقاقی
                    this.DoConcept(1006).Value += this.DoConcept(1011).Value / this.DoConcept(1001).Value;
                    this.DoConcept(1011).Value = this.DoConcept(1011).Value % this.DoConcept(1001).Value;
                    if (this.DoConcept(1011).Value == 0) this.DoConcept(1011).Value = 1;
                }

                // شرط اضافه شد
                // در صورتیکه مفاهیم هر روز مقدار داشته باشد و در پایان دوره
                // با مفهوم ماهانه صفر شوند برای نمایش روزانه ها این شرط اضافه شده
                if (this.DoConcept(1016).Value > 0)
                {
                    //استعلاجی
                    this.DoConcept(1017).Value += this.DoConcept(1016).Value / this.DoConcept(1001).Value;
                    this.DoConcept(1016).Value = this.DoConcept(1016).Value % this.DoConcept(1001).Value;
                    if (this.DoConcept(1016).Value == 0) this.DoConcept(1016).Value = 1;
                }

                // شرط اضافه شد
                // در صورتیکه مفاهیم هر روز مقدار داشته باشد و در پایان دوره
                // با مفهوم ماهانه صفر شوند برای نمایش روزانه ها این شرط اضافه شده
                //بی حقوق
                if (this.DoConcept(1073).Value > 0)
                {
                    this.DoConcept(1074).Value += this.DoConcept(1073).Value / this.DoConcept(1001).Value;
                    this.DoConcept(1073).Value = this.DoConcept(1073).Value % this.DoConcept(1001).Value;
                    if (this.DoConcept(1073).Value == 0) this.DoConcept(1073).Value = 1;
                }

                // شرط اضافه شد
                // در صورتیکه مفاهیم هر روز مقدار داشته باشد و در پایان دوره
                // با مفهوم ماهانه صفر شوند برای نمایش روزانه ها این شرط اضافه شده
                if (this.DoConcept(1074).Value > 0)
                {
                    this.DoConcept(1076).Value += this.DoConcept(1074).Value / this.DoConcept(1001).Value;
                    this.DoConcept(1074).Value = this.DoConcept(1074).Value % this.DoConcept(1001).Value;
                    if (this.DoConcept(1074).Value == 0) this.DoConcept(1074).Value = 1;
                }

                // شرط اضافه شد
                // در صورتیکه مفاهیم هر روز مقدار داشته باشد و در پایان دوره
                // با مفهوم ماهانه صفر شوند برای نمایش روزانه ها این شرط اضافه شده
                if (this.DoConcept(1043).Value > 0)
                {
                    // مرخصی با حقوق
                    this.DoConcept(1048).Value += this.DoConcept(1043).Value / this.DoConcept(1001).Value;
                    this.DoConcept(1043).Value += this.DoConcept(1043).Value / this.DoConcept(1001).Value;
                    if (this.DoConcept(1043).Value == 0) this.DoConcept(1043).Value = 1;
                }

                // شرط اضافه شد
                // در صورتیکه مفاهیم هر روز مقدار داشته باشد و در پایان دوره
                // با مفهوم ماهانه صفر شوند برای نمایش روزانه ها این شرط اضافه شده
                if (this.DoConcept(1044).Value > 0)
                {
                    this.DoConcept(1049).Value += this.DoConcept(1044).Value / this.DoConcept(1001).Value;
                    this.DoConcept(1044).Value += this.DoConcept(1044).Value / this.DoConcept(1001).Value;
                    if (this.DoConcept(1044).Value == 0) this.DoConcept(1044).Value = 1;
                }

                // شرط اضافه شد
                // در صورتیکه مفاهیم هر روز مقدار داشته باشد و در پایان دوره
                // با مفهوم ماهانه صفر شوند برای نمایش روزانه ها این شرط اضافه شده
                if (this.DoConcept(1045).Value > 0)
                {
                    this.DoConcept(1050).Value += this.DoConcept(1045).Value / this.DoConcept(1001).Value;
                    this.DoConcept(1045).Value += this.DoConcept(1045).Value / this.DoConcept(1001).Value;
                    if (this.DoConcept(1045).Value == 0) this.DoConcept(1045).Value = 1;
                }

                // شرط اضافه شد
                // در صورتیکه مفاهیم هر روز مقدار داشته باشد و در پایان دوره
                // با مفهوم ماهانه صفر شوند برای نمایش روزانه ها این شرط اضافه شده
                if (this.DoConcept(1046).Value > 0)
                {
                    this.DoConcept(1051).Value += this.DoConcept(1046).Value / this.DoConcept(1001).Value;
                    this.DoConcept(1046).Value += this.DoConcept(1046).Value / this.DoConcept(1001).Value;

                    if (this.DoConcept(1046).Value == 0) this.DoConcept(1046).Value = 1;
                }

                // شرط اضافه شد
                // در صورتیکه مفاهیم هر روز مقدار داشته باشد و در پایان دوره
                // با مفهوم ماهانه صفر شوند برای نمایش روزانه ها این شرط اضافه شده
                if (this.DoConcept(1047).Value > 0)
                {
                    this.DoConcept(1052).Value += this.DoConcept(1047).Value / this.DoConcept(1001).Value;
                    this.DoConcept(1047).Value += this.DoConcept(1047).Value / this.DoConcept(1001).Value;

                    if (this.DoConcept(1047).Value == 0) this.DoConcept(1047).Value = 1;
                }
            }
            GetLog(MyRule, " After Execute State:", 1006, 1011, 1017, 1016, 1074, 1073, 1076, 1074, 1043, 1044, 1045, 1046, 1047, 1048, 1049, 1050, 1051, 1052);
        }

        /// <summary>قانون مرخصي 3-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي هفتاد-3003 درنظر گرفته شده است</remarks>
        public virtual void R70(AssignedRule MyRule)
        {
            //1 مفهوم حضور
            //1001 مفهوم مرخصي درروز
            //مرخصي استحقاقي ساعتي 1003  
            //مرخصي استحقاقي روزانه 1005        
            //3001 مفهوم غيبت خالص ساعتي           
            //1014 مفهوم مرخصي استحقاقي بدون حقوق  در صورت عدم طلب مرخصي استحقاقي
            //1056 مرخصي بی حقوق ساعتي
            //1066 مرخصي بی حقوق روزانه
            //2030 کار خارج از اداره
            //2023 مجموع ماموريت ساعتي

            //4025 تبدیل حضور به اضافه کار در روز مرخصی

            int leaveHour = this.DoConcept(1003).Value;
            if (leaveHour > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                GetLog(MyRule, " Before Execute State:", 1003, 1005, 4002);

                int leaveInDay = this.DoConcept(1001).Value;
                int demandLeave = this.Person.GetRemainLeave(this.RuleCalculateDate);
                this.DoConcept(1005).Value = 1;
                this.Person.AddUsedLeave(this.RuleCalculateDate, leaveInDay - leaveHour, null);
                this.DoConcept(1003).Value = 0;
                ((PairableScndCnpValue)this.DoConcept(3001)).ClearPairs();
                this.DoConcept(3020).Value = 0;
                this.ReCalculate(3008, 3010, 3014, 3029, 3030, 3031, 3028);

                GetLog(MyRule, " After Execute State:", 1003, 1005, 4002);
            }

            //1008 مرخصي استعلاجي ساعتي
            //1010 مرخصي استعلاجي روزانه

            if (this.DoConcept(1008).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                GetLog(MyRule, " Before Execute ", 1010, 1008, 4002);

                this.DoConcept(1010).Value = 1;
                ((PairableScndCnpValue)this.DoConcept(1008)).ClearPairs();
                GetLog(MyRule, " After Execute ", 1010, 1008, 4002);

            }

            //مرخصی با حقوق
            if (this.DoConcept(1038).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                GetLog(MyRule, " Before Execute ", 1031, 1038, 4002);

                this.DoConcept(1031).Value = 1;
                this.DoConcept(1038).Value = 0;

                GetLog(MyRule, " After Execute ", 1031, 1038, 4002);

            }
            if (this.DoConcept(1039).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                GetLog(MyRule, " Before Execute ", 1029, 1039, 4002);

                this.DoConcept(1029).Value = 1;
                this.DoConcept(1039).Value = 0;

                GetLog(MyRule, " After Execute ", 1029, 1039, 4002);

            }
            if (this.DoConcept(1040).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                GetLog(MyRule, " Before Execute ", 1037, 1040, 4002);

                this.DoConcept(1037).Value = 1;
                this.DoConcept(1040).Value = 0;

                GetLog(MyRule, " After Execute ", 1037, 1040, 4002);

            }
            if (this.DoConcept(1041).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                GetLog(MyRule, " Before Execute ", 1033, 1041, 4002);

                this.DoConcept(1033).Value = 1;
                this.DoConcept(1041).Value = 0;

                GetLog(MyRule, " After Execute ", 1033, 1041, 4002);

            }
            if (this.DoConcept(1042).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                GetLog(MyRule, " Before Execute ", 1035, 1042, 4002);

                this.DoConcept(1035).Value = 1;
                this.DoConcept(1042).Value = 0;

                GetLog(MyRule, " After Execute ", 1035, 1042, 4002);

            }

            //مرخصی بی حقوق
            if (this.DoConcept(1054).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                GetLog(MyRule, " Before Execute ", 1066, 1054, 4002);

                this.DoConcept(1066).Value = 1;
                this.DoConcept(1054).Value = 0;

                GetLog(MyRule, " After Execute ", 1066, 1054, 4002);

            }
            if (this.DoConcept(1056).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                GetLog(MyRule, " Before Execute ", 1066, 1056, 4002);

                this.DoConcept(1066).Value = 1;
                this.DoConcept(1056).Value = 0;

                GetLog(MyRule, " After Execute ", 1066, 1056, 4002);

            }
            if (this.DoConcept(1058).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                GetLog(MyRule, " Before Execute ", 1066, 1058, 4002);

                this.DoConcept(1066).Value = 1;
                this.DoConcept(1058).Value = 0;

                GetLog(MyRule, " After Execute ", 1066, 1058, 4002);

            }
            if (this.DoConcept(1060).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                GetLog(MyRule, " Before Execute ", 1066, 1060, 4002);

                this.DoConcept(1066).Value = 1;
                this.DoConcept(1060).Value = 0;

                GetLog(MyRule, " After Execute ", 1066, 1060, 4002);

            }
            if (this.DoConcept(1062).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                GetLog(MyRule, " Before Execute ", 1066, 1062, 4002);

                this.DoConcept(1066).Value = 1;
                this.DoConcept(1062).Value = 0;

                GetLog(MyRule, " After Execute ", 1066, 1062, 4002);
            }
            this.ReCalculate(1090);
        }

        /// <summary>قانون مرخصي 4-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي هفتاد و  يک-71 درنظر گرفته شده است</remarks>
        public virtual void R71(AssignedRule MyRule)
        {
            //مرخصي استحقاقي ساعتي 1003           
            //1 مفهوم حضور             
            //3004 مفهوم غيبت روزانه
            //4002 مفهوم اضافه کارساعتي
            //4024 تبدیل حضور به اضافه کار در روز غیبت

            GetLog(MyRule, " Before Execute State:", 2, 4, 1003, 1005, 1007, 3004, 3020, 1010, 1008, 4002, 1031, 1038, 1029, 1039, 1037, 1040, 1033, 1041, 1054, 1056, 1058, 1060, 1062, 1064, 1066, 1068, 1070, 1072, 4024);
            if (this.DoConcept(1).Value > 0 && this.DoConcept(1003).Value >= MyRule["First", this.RuleCalculateDate].ToInt())
            {
                this.Person.AddRemainLeave(this.RuleCalculateDate, this.DoConcept(1003).Value);
                this.Person.AddRemainLeave(this.RuleCalculateDate, this.DoConcept(1005).Value * this.DoConcept(1001).Value);

                this.DoConcept(3004).Value = 1;

                this.DoConcept(1003).Value = 0;
                this.DoConcept(1005).Value = 0;

                this.DoConcept(2).Value = 0;
                this.DoConcept(4).Value = 0;

                this.DoConcept(3020).Value = 0;
                //((PairableScndCnpValue)this.DoConcept(3028)).ClearPairs();

                this.DoConcept(4024).Value = 1;
                ((PairableScndCnpValue)this.DoConcept(4002)).AddPairs(this.DoConcept(1));

                this.ReCalculate(13, 3004);
            }

            //1008 مرخصي استعلاجي ساعتي
            //1010 مرخصي استعلاجي روزانه

            if (this.DoConcept(1008).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                this.DoConcept(3004).Value = 1;
                this.DoConcept(2).Value = 0;
                this.DoConcept(4).Value = 0;
                this.DoConcept(1008).Value = 0;
                this.DoConcept(1010).Value = 0;
                this.DoConcept(4024).Value = 1;
                ((PairableScndCnpValue)this.DoConcept(4002)).AddPairs(this.DoConcept(1));
            }

            //مرخصی با حقوق
            if (this.DoConcept(1038).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                this.DoConcept(3004).Value = 1;
                this.DoConcept(2).Value = 0;
                this.DoConcept(4).Value = 0;
                this.DoConcept(1031).Value = 0;
                this.DoConcept(1038).Value = 0;
                this.DoConcept(4024).Value = 1;
                ((PairableScndCnpValue)this.DoConcept(4002)).AddPairs(this.DoConcept(1));
            }
            if (this.DoConcept(1039).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                this.DoConcept(3004).Value = 1;
                this.DoConcept(2).Value = 0;
                this.DoConcept(4).Value = 0;
                this.DoConcept(1029).Value = 0;
                this.DoConcept(1039).Value = 0;
                this.DoConcept(4024).Value = 1;
                ((PairableScndCnpValue)this.DoConcept(4002)).AddPairs(this.DoConcept(1));
            }
            if (this.DoConcept(1040).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                this.DoConcept(3004).Value = 1;
                this.DoConcept(2).Value = 0;
                this.DoConcept(4).Value = 0;
                this.DoConcept(1037).Value = 0;
                this.DoConcept(1040).Value = 0;
                this.DoConcept(4024).Value = 1;
                ((PairableScndCnpValue)this.DoConcept(4002)).AddPairs(this.DoConcept(1));
            }
            if (this.DoConcept(1041).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                this.DoConcept(3004).Value = 1;
                this.DoConcept(2).Value = 0;
                this.DoConcept(4).Value = 0;
                this.DoConcept(1033).Value = 0;
                this.DoConcept(1041).Value = 0;
                this.DoConcept(4024).Value = 1;
                ((PairableScndCnpValue)this.DoConcept(4002)).AddPairs(this.DoConcept(1));
            }
            if (this.DoConcept(1042).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                this.DoConcept(3004).Value = 1;
                this.DoConcept(2).Value = 0;
                this.DoConcept(4).Value = 0;
                this.DoConcept(1035).Value = 0;
                this.DoConcept(1042).Value = 0;
                this.DoConcept(4024).Value = 1;
                ((PairableScndCnpValue)this.DoConcept(4002)).AddPairs(this.DoConcept(1));
            }

            //مرخصی بی حقوق
            if (this.DoConcept(1054).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                this.DoConcept(3004).Value = 1;
                this.DoConcept(2).Value = 0;
                this.DoConcept(4).Value = 0;
                this.DoConcept(1064).Value = 0;
                this.DoConcept(1054).Value = 0;
                this.DoConcept(4024).Value = 1;
                ((PairableScndCnpValue)this.DoConcept(4002)).AddPairs(this.DoConcept(1));
            }
            if (this.DoConcept(1056).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                this.DoConcept(3004).Value = 1;
                this.DoConcept(2).Value = 0;
                this.DoConcept(4).Value = 0;
                this.DoConcept(1066).Value = 0;
                this.DoConcept(1056).Value = 0;
                this.DoConcept(4024).Value = 1;
                ((PairableScndCnpValue)this.DoConcept(4002)).AddPairs(this.DoConcept(1));
            }
            if (this.DoConcept(1058).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                this.DoConcept(3004).Value = 1;
                this.DoConcept(2).Value = 0;
                this.DoConcept(4).Value = 0;
                this.DoConcept(1068).Value = 0;
                this.DoConcept(1058).Value = 0;
                this.DoConcept(4024).Value = 1;
                ((PairableScndCnpValue)this.DoConcept(4002)).AddPairs(this.DoConcept(1));
            }
            if (this.DoConcept(1060).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                this.DoConcept(3004).Value = 1;
                this.DoConcept(2).Value = 0;
                this.DoConcept(4).Value = 0;
                this.DoConcept(1070).Value = 0;
                this.DoConcept(1060).Value = 0;
                this.DoConcept(4024).Value = 1;
                ((PairableScndCnpValue)this.DoConcept(4002)).AddPairs(this.DoConcept(1));
            }
            if (this.DoConcept(1062).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                this.DoConcept(3004).Value = 1;
                this.DoConcept(2).Value = 0;
                this.DoConcept(4).Value = 0;
                this.DoConcept(1072).Value = 0;
                this.DoConcept(1062).Value = 0;
                this.DoConcept(4024).Value = 1;
                ((PairableScndCnpValue)this.DoConcept(4002)).AddPairs(this.DoConcept(1));
            }

            GetLog(MyRule, " After Execute State:", 2, 4, 1003, 1005, 1007, 3004, 3020, 1010, 1008, 4002, 1031, 1038, 1029, 1039, 1037, 1040, 1033, 1041, 1054, 1056, 1058, 1060, 1062, 1064, 1066, 1068, 1070, 1072, 4024);
        }

        /// <summary>قانون مرخصي 5-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي هفتاد و دو-72 درنظر گرفته شده است</remarks>
        public virtual void R72(AssignedRule MyRule)
        {
            throw new Exception("در مفهوم مرخصی خالص ساعتی اعمال گرددید");
            //3034 مفهوم غيبت ساعتي ماهانه
            //1011 مفهوم مرخصي استحقاقي ساعتي ماهانه            
            //8 مفهوم کارکردخالص ساعتي ماهانه
            //1074 مرخصی بی حقوق ساعتی ماهانه

            GetLog(MyRule, " Before Execute State:", 3034, 1011);
            if (this.DoConcept(1011).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                if (this.DoConcept(1014).Value > 0)
                {
                    this.DoConcept(1074).Value += this.DoConcept(1011).Value - MyRule["First", this.RuleCalculateDate].ToInt();
                }
                else
                {
                    this.DoConcept(3034).Value += this.DoConcept(1011).Value - MyRule["First", this.RuleCalculateDate].ToInt();
                }

                this.Person.AddRemainLeave(this.RuleCalculateDate, this.DoConcept(1011).Value - MyRule["First", this.RuleCalculateDate].ToInt());
                this.DoConcept(1011).Value = MyRule["First", this.RuleCalculateDate].ToInt();

            }
            GetLog(MyRule, " After Execute State:", 3034, 1011);
        }

        /// <summary>قانون مرخصي 5-2</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي هفتاد و سه-73 درنظر گرفته شده است</remarks>
        public virtual void R73(AssignedRule MyRule)
        {
            throw new Exception("در مفهوم مرخصی خالص ساعتی اعمال گرددید");
            //3028 مفهوم غيبت ساعتي 
            //مرخصي استحقاقي ساعتي 1003
            //1011 مفهوم مرخصي استحقاقي ساعتي ماهانه            
            //8 مفهوم کارکردخالص ساعتي ماهانه
            //1092 مفهوم تعداد بازه های ماهانه ی مرخصی ساعتی
            //2 مفهوم کارکرد خالص ساعتی

            GetLog(MyRule, " Before Execute State:RemainLeave[" + this.Person.GetRemainLeave(this.RuleCalculateDate) + "]", 1003, 1011, 1092, 1093, 3028, 3001, 1002);

            this.DoConcept(1002);
            this.DoConcept(1056);
            if (this.DoConcept(1092).Value > MyRule["First", this.RuleCalculateDate].ToInt()
                && ((PairableScndCnpValue)this.DoConcept(1003)).PairCount > 0)
            {
                int count = this.DoConcept(1092).Value - MyRule["First", this.RuleCalculateDate].ToInt();
                for (int i = 0; i < count; i++)
                {
                    int _tmp = ((PairableScndCnpValue)this.DoConcept(1003)).Pairs.OrderBy(x => x.From).Last().Value;
                    IPair pair = ((PairableScndCnpValue)this.DoConcept(1003)).Pairs.OrderBy(x => x.From).Last();

                    PairableScndCnpValue.AppendPairToScndCnpValue(pair, this.DoConcept(3001));

                    this.Person.AddRemainLeave(this.RuleCalculateDate, _tmp);
                    this.DoConcept(1011).Value -= _tmp;
                    this.DoConcept(1003).Value -= _tmp;
                    ((PairableScndCnpValue)this.DoConcept(1003)).RemovePairAt(((PairableScndCnpValue)this.DoConcept(1003)).Pairs.Count - 1);
                }
                if (count > 0)
                {
                    this.ReCalculate(3028, 3029, 3030, 3031, 3008, 3010, 3014);
                }
                this.DoConcept(1093).Value -= count;
                this.DoConcept(1092).Value -= count;
            }
            GetLog(MyRule, " After Execute State:RemainLeave[" + this.Person.GetRemainLeave(this.RuleCalculateDate) + "]", 1003, 1011, 1092, 1092, 3028, 3001, 1002);
        }

        /// <summary>قانون مرخصي 6-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي هفتاد و چهار-74 درنظر گرفته شده است</remarks>
        public virtual void R74(AssignedRule MyRule)
        {
            throw new Exception("در مفهوم مرخصی خالص ساعتی اعمال گرددید");
            //1012 مفهوم مرخصي استحقاقي ساعتي سالانه
            //3007 مفهوم غيبت ساعتي سالانه
            //19 مفهوم کارکردخالص ساعتي سالانه
            //8 مفهوم کارکردخالص ساعتي ماهانه

            int tmp = this.DoConcept(1012).Value - MyRule["First", this.RuleCalculateDate].ToInt();
            if (this.DoConcept(1012).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                GetLog(MyRule, " Before Execute State:RemainLeave[" + this.Person.GetRemainLeave(this.RuleCalculateDate) + "]", 19, 1012, 3007);
                this.DoConcept(3007).Value += tmp;
                this.DoConcept(19).Value -= tmp;
                this.Person.AddRemainLeave(this.RuleCalculateDate, tmp);
                this.DoConcept(1012).Value = MyRule["First", this.RuleCalculateDate].ToInt();
                GetLog(MyRule, " After Execute State:RemainLeave[" + this.Person.GetRemainLeave(this.RuleCalculateDate) + "]", 19, 1012, 3007);
            }
        }

        /// <summary>قانون مرخصي 6-2</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي هفتاد و پنج-3005 درنظر گرفته شده است</remarks>
        public virtual void R75(AssignedRule MyRule)
        {
            //1003 مفهوم مرخصي استحقاقي ساعتي
            //3001 غيبت خالص ساعتي
            //2 کارکردخالص ساعتي
            GetLog(MyRule, " Before Execute State:", 1003, 3028);

            var execptList =
                ((PairableScndCnpValue)this.DoConcept(1003)).Pairs.Where(
                    x => x.Value < MyRule["First", this.RuleCalculateDate].ToInt()).ToList();

            if (execptList.Any())
            {
                ((PairableScndCnpValue)this.DoConcept(1003)).RemovePairs(execptList);
                ((PairableScndCnpValue)this.DoConcept(3028)).AppendPairs(execptList);

                this.Person.AddRemainLeave(this.RuleCalculateDate, execptList.Sum(x => x.Value));
            }




            GetLog(MyRule, " After Execute State:", 1003, 3028);

        }

        /// <summary>قانون مرخصي 7-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي هفتاد و شش-8 درنظر گرفته شده است</remarks>
        public virtual void R76(AssignedRule MyRule)
        {
            //1011 مفهوم مرخصي استحقاقي ساعتي ماهانه
            //1094 مفهوم اگر مرخصی ماهانه از حد بخشش گذشت شامل بخشش نشود

            GetLog(MyRule, " Before Execute State:", 1011, 1094);
            if (this.DoConcept(1011).Value <= MyRule["First", this.RuleCalculateDate].ToInt() && this.DoConcept(1011).Value > 0
                || MyRule["NotApplyIfGreater", this.RuleCalculateDate].ToInt() == 0)
            {
                int temp = Operation.Minimum(MyRule["First", this.RuleCalculateDate].ToInt(), this.DoConcept(1011).Value);
                this.DoConcept(1011).Value -= temp;
                this.Person.AddRemainLeave(this.RuleCalculateDate, temp);
            }

            GetLog(MyRule, " After Execute State:", 1011, 1094);
        }

        /// <summary>قانون مرخصي 7-2</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي هفتاد و هفت-77 درنظر گرفته شده است</remarks>
        public virtual void R77(AssignedRule MyRule)
        {
            throw new Exception("در پارامتر اعمال شده , ار رده خارج");
            //1094 مفهوم اگر مرخصی ماهانه از حد بخشش گذشت شامل بخشش نشود
            this.DoConcept(1094).Value = 1;
        }

        /// <summary>قانون مرخصي 9-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي هفتاد و هفت-77 درنظر گرفته شده است</remarks>
        public virtual void R101(AssignedRule MyRule)
        {
            throw new Exception("در مفهوم مرخصی خالص ساعتی اعمال گرددید");
            //1015 مرخصی بی حقوق در صورت عدم طلب مرخصی استعلاجی
            //1010 مرخصی استعلاجی روزانه
            //1008 مرخصی استعلاجی ساعتی
            //1016 مرخصی استعلاجی ساعتی ماهانه
            //1017 مرخصی استعلاجی روزانه ماهانه
            //1018 مرخصی استعلاجی روزانه سالانه
            //1019 مرخصی استعلاجی ساعتی سالانه
            //1014 درصورت عدم طلب مرخصی به بی حقوق تبدیل شود
            //1056 مرخصی بی حقوق ساعتی_12
            //1066 مرخصی بی حقوق روزانه_32
            //3028 غیبت غیر مجاز ساعتی
            //3004 غیبت غیر مجاز روزانه

            GetLog(MyRule, " Before Execute State:", 1018, 1019, 1056, 1066, 3028, 3004, 1008, 1010);

            if (this.DoConcept(1018).Value * this.DoConcept(1001).Value + this.DoConcept(1019).Value
                >= MyRule["First", this.RuleCalculateDate].ToInt() * this.DoConcept(1001).Value)
            {
                if (this.DoConcept(1015).Value == 1)
                {
                    this.DoConcept(1056).Value = this.DoConcept(1008).Value;
                    this.DoConcept(1066).Value = this.DoConcept(1010).Value;
                }
                else
                {
                    this.DoConcept(3028).Value = this.DoConcept(1008).Value;
                    this.DoConcept(3004).Value = this.DoConcept(1010).Value;
                }
                this.DoConcept(1008).Value = 0;
                this.DoConcept(1010).Value = 0;
                this.ReCalculate(1018, 1019);
            }

            GetLog(MyRule, " After Execute State:", 1018, 1019, 1056, 1066, 3028, 3004, 1008, 1010);
        }

        /// <summary>قانون مرخصي 10-2</summary>
        ///<remarks>شناسه اين قانون در تعاريف بعدي هفتاد و هشت-9 درنظر گرفته شده است</remarks>
        public virtual void R78(AssignedRule MyRule)
        {
            //1078 مرخصی استحقاقی اول وقت
            //1079 تعداد مرخصی استحقاقی اول وقت در روز
            //1080 تعداد مرخصی استحقاقی اول وقت در ماه
            GetLog(MyRule, " Before Execute State:", 1003, 3028, 1056, 1078);

            if (this.DoConcept(1080).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                if (this.DoConcept(1079).Value == 1)
                {
                    this.Person.AddRemainLeave(this.RuleCalculateDate, ((PairableScndCnpValue)this.DoConcept(1078)).Pairs[0].Value);
                    ((PairableScndCnpValue)this.DoConcept(1003)).RemovePair(((PairableScndCnpValue)this.DoConcept(1078)).Pairs[0]);
                    if (this.DoConcept(1014).Value == 1)
                    {
                        this.DoConcept(1056).Value += this.DoConcept(1078).Value;
                    }
                    else
                    {
                        this.DoConcept(3028).Value += this.DoConcept(1078).Value;
                    }
                    ((PairableScndCnpValue)this.DoConcept(1078)).ClearPairs();
                }
                else
                {
                    throw new UnforeseenState("اگر تعداد مرخصی اول وقت در ماه بیشتر از تعداد مجاز شد باید این مقدارغیر مجاز حتما مربوط به امروز شود", "قانون 104");
                }
            }

            GetLog(MyRule, " After Execute State:", 1003, 3028, 1056, 1078);
        }

        /// <summary>قانون مرخصي 14-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي هفتاد و نه-79 درنظر گرفته شده است</remarks>
        public virtual void R79(AssignedRule MyRule)
        {
            //تقويم تعطيل رسمي 1
            //تعطيل غير رسمي 2
            //تعطيل نوروز 4

            //2 مفهوم کارکردخالص ساعتي
            //4 مفهوم کارکردخالص روزانه
            //مرخصي درروز 1001
            //مرخصي استحقاقي روزانه 1005
            //مرخصي استحقاقي ساعتي 1003

            //1008 مرخصي استعلاجي ساعتي

            //1038,1039,1040,1041,1042 مرخصی باحقوق ساعتی
            //1043,1044,1045,1046,1047 مرخصی باحقوق روزانه

            //1090 مفهوم مجموع انواع مرخصی روزانه
            //1088 مفهوم مرخصی به کارکرد خالص اضافه شود
            GetLog(MyRule, " Before Execute State:", 4, 2);

            this.DoConcept(1088).Value = 1;
            if (this.Person.GetShiftByDate(this.RuleCalculateDate).PairCount > 0
                 && this.Person.GetShiftByDate(this.RuleCalculateDate).ShiftType != ShiftTypesEnum.OVERTIME)
            {
                if (this.DoConcept(1090).Value > 0)
                {
                    this.DoConcept(4).Value = 1;
                    this.DoConcept(2).Value = this.Person.GetShiftByDate(this.RuleCalculateDate).Value;
                    this.ReCalculate(13);
                }
                else
                {
                    int value = 0;
                    value += Operation.Intersect(this.Person.GetShiftByDate(this.RuleCalculateDate), this.DoConcept(1003)).Value;
                    value += Operation.Intersect(this.Person.GetShiftByDate(this.RuleCalculateDate), this.DoConcept(1008)).Value;
                    value += Operation.Intersect(this.Person.GetShiftByDate(this.RuleCalculateDate), this.DoConcept(1038)).Value;
                    value += Operation.Intersect(this.Person.GetShiftByDate(this.RuleCalculateDate), this.DoConcept(1039)).Value;
                    value += Operation.Intersect(this.Person.GetShiftByDate(this.RuleCalculateDate), this.DoConcept(1040)).Value;
                    value += Operation.Intersect(this.Person.GetShiftByDate(this.RuleCalculateDate), this.DoConcept(1042)).Value;
                    if (value > 0)
                    {
                        this.DoConcept(4).Value = 1;
                        this.DoConcept(2).Value += value;
                        this.ReCalculate(13);
                    }
                }
            }
            GetLog(MyRule, " After Execute State:", 4, 2);
        }

        /// <summary>قانون مرخصي 14-2</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي هشتاد-80 درنظر گرفته شده است</remarks>
        public virtual void R80(AssignedRule MyRule)
        {
            //13 کارکردناخالص
            //1005 مفهوم مرخصي استحقاقي روزانه
            //1003 مفهوم مرخصي استحقاقي ساعتي
            //110 مفهوم مرخصي بايد به کارکرد خالص اضافه شود
            //1001 مرخصي درروز

            //مرخصی ساعتی با حقوق-دادگاه 1025
            //مرخصی ساعتی با حقوق 1027

            //مرخصی با حقوق روزانه_فوت بستگان 1029
            //مرخصی با حقوق روزانه_جبرانی ماموریت 1031
            //مرخصی با حقوق روزانه_زایمان 1033
            //مرخصی با حقوق روزانه 1035
            //مرخصی با حقوق روزانه-دادگاه ورزشی 1037

            //1090 مفهوم مجموع انواع مرخصی روزانه

            GetLog(MyRule, " Before Execute State:", 13);
            if (MyRule["First", this.RuleCalculateDate].ToInt() == 0 &&
                !EngEnvironment.HasCalendar(this.RuleCalculateDate, "1", "2", "4") &&
                this.Person.GetShiftByDate(this.RuleCalculateDate).Pairs.Count > 0)
            {
                if (this.DoConcept(1090).Value >= 1)
                {
                    this.DoConcept(13).Value = this.Person.GetShiftByDate(this.RuleCalculateDate).Value;
                    this.DoConcept(13).Value += this.DoConcept(4002).Value;
                }
                else
                {
                    //به دلیل اینکه در اضافه کار مرخصی های خارج از شیفت
                    //لحاظ شده است و در تعریف کارکردناخالص به آن اضافه گشته
                    //در این جا اشتراک مرخصی و شیفت را به کارکردناخالص اضافه میکنیم

                    int value = 0;
                    value += Operation.Intersect(this.Person.GetShiftByDate(this.RuleCalculateDate), this.DoConcept(1003)).Value;
                    value += Operation.Intersect(this.Person.GetShiftByDate(this.RuleCalculateDate), this.DoConcept(1008)).Value;
                    value += Operation.Intersect(this.Person.GetShiftByDate(this.RuleCalculateDate), this.DoConcept(1038)).Value;
                    value += Operation.Intersect(this.Person.GetShiftByDate(this.RuleCalculateDate), this.DoConcept(1025)).Value;
                    value += Operation.Intersect(this.Person.GetShiftByDate(this.RuleCalculateDate), this.DoConcept(1027)).Value;
                    if (value > 0)
                    {
                        this.DoConcept(13).Value += value;
                    }
                }
            }
            else //مرخصی به کارکرد خالص اضافه شده و حالا کافی است کارکرد ناخالص دوباره محاسبه شود
            {
                this.ReCalculate(13);
            }
            GetLog(MyRule, " Before Execute State:", 13);
        }

        /// <summary>قانون مرخصي 15-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي هشتاد و يک-81 درنظر گرفته شده است</remarks>
        /// مرخصي 15-1: تعطيلات بين مرخصي جزو مرخصي حساب شود
        public virtual void R81(AssignedRule MyRule)
        {
            throw new Exception("در قانون مربوطه بصورت پارامتر ارسال شد  , از رده خارج");
            //325 تعطیلات غیر رسمی بین مرخصی,مرخصی محسوب شود
            GetLog(MyRule, " Before Execute State:", 325);
            this.DoConcept(325).Value = 1;
            GetLog(MyRule, " After Execute State:", 325);
        }

        /// <summary>قانون مرخصي 16-2</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي هشتاد و چهار-2009 درنظر گرفته شده است</remarks>
        public virtual void R84(AssignedRule MyRule)
        {
            throw new Exception("در قانون مربوطه بصورت پارامتر ارسال شد  , از رده خارج");
            //1010 مفهوم مرخصي استعلاجي روزانه
            //تعطيل رسمي 1
            //114 مفهوم اعمال تعطيلات نوروز در مرخصي    
            //328 مفهوم تعطیلات غیر رسمی بین مرخصی استعلاجی,مرخصی استعلاجی محسوب شود

            GetLog(MyRule, " Before Execute State:", 328);
            this.DoConcept(328).Value = 1;
            GetLog(MyRule, " After Execute State:", 328);
        }

        /// <summary>قانون مرخصي 17-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي هشتاد و پنج-2010 درنظر گرفته شده است</remarks>
        public virtual void R85(AssignedRule MyRule)
        {
            throw new Exception("در قانون مربوطه بصورت پارامتر ارسال شد  , از رده خارج");
            //326 مفهوم روزهای غیر کاری بین مرخصی,مرخصی محسوب شود
            GetLog(MyRule, " Before Execute State:", 326);
            this.DoConcept(326).Value = 1;
            GetLog(MyRule, " After Execute State:", 326);
        }

        /// <summary>قانون مرخصي 17-2</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي هشتاد و شش-2011 درنظر گرفته شده است</remarks>
        public virtual void R86(AssignedRule MyRule)
        {
            throw new Exception("در قانون مربوطه بصورت پارامتر ارسال شد  , از رده خارج");
            //1010 مفهوم مرخصي استعلاجي روزانه
            //تعطيل نوروز 4
            //329 مفهوم روزهای غیر کاری بین مرخصی استعلاجی,مرخصی استعلاجی محسوب شود
            GetLog(MyRule, " Before Execute State:", 329);
            this.DoConcept(329).Value = 1;
            GetLog(MyRule, " After Execute State:", 329);

        }

        /// <summary>قانون مرخصي 19-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي هشتاد و هفت-2012 درنظر گرفته شده است</remarks>
        public virtual void R100(AssignedRule MyRule)
        {
            //1021 مرخصي قطعي در روزغيرکاري         
            GetLog(MyRule, " Before Execute State:", 1021);
            this.DoConcept(1021).Value = 1;
            GetLog(MyRule, " After Execute State:", 1021);
        }

        /// <summary>قانون مرخصي 20-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي هشتاد و هشت-89 درنظر گرفته شده است</remarks>
        public virtual void R88(AssignedRule MyRule)
        {
            //1022 مرخصي بي حقوق بيماري قطعي در روزغيرکاري
            //1054 مفهوم مرخصی بیماری بی حقوق ساعتی_11
            //1063 مرخصی بیماری بی حقوق خالص روزانه_31
            //1031 مفهوم مرخصی بیماری بی حقوق روزانه_31
            //1030 مفهوم مرخصی بیماری بی حقوق خالص روزانه_31
            GetLog(MyRule, " Before Execute State:", 1054, 1064);
            this.DoConcept(1022).Value = 1;
            if (this.DoConcept(1063).Value == 1)
            {
                this.DoConcept(1064).Value = 1;
                this.DoConcept(1054).Value = 0;
            }
            GetLog(MyRule, " After Execute State:", 1054, 1064);
        }

        /// <summary>قانون مرخصي 21-1</summary>
        /// <remarks>این قانون بصورت عکس فعال میشود یعنی ما در حالت عادی مرخصی اول وقت میدهیم
        /// و در صورتی که این قانون تیک نخورده بود مرخصی داده شده را پس میگیریم</remarks>
        public virtual void R104(AssignedRule MyRule)
        {
            //1003  مرخصی ساعتی استحقاقی
            //1008 مرخصی ساعتی استعلاجی
            //1038 مرخصی ساعتی باحقوق_23
            //1039 مرخصی ساعتی باحقوق_24
            //1040 مرخصی ساعتی باحقوق_25
            //1041 مرخصی ساعتی باحقوق_26
            //1042 مرخصی ساعتی باحقوق_27
            GetLog(MyRule, " Before Execute State:", 1003, 1008, 1038, 1039, 1040, 1041, 1042);
            if (this.Person.GetShiftByDate(this.RuleCalculateDate).Value > 0)
            {
                int startShift = this.Person.GetShiftByDate(this.RuleCalculateDate).PastedPairs.From;
                IPair pair;
                if (this.DoConcept(1003).Value > 0)
                {
                    pair = ((PairableScndCnpValue)this.DoConcept(1003)).Pairs.Where(x => x.From == startShift).FirstOrDefault();
                    if (pair != null)
                    {
                        this.Person.AddRemainLeave(this.RuleCalculateDate, pair.Value);
                    }
                    ((PairableScndCnpValue)this.DoConcept(1003)).RemovePair(pair);
                }

                pair = ((PairableScndCnpValue)this.DoConcept(1008)).Pairs.Where(x => x.From == startShift).FirstOrDefault();
                ((PairableScndCnpValue)this.DoConcept(1008)).RemovePair(pair);

                pair = ((PairableScndCnpValue)this.DoConcept(1038)).Pairs.Where(x => x.From == startShift).FirstOrDefault();
                ((PairableScndCnpValue)this.DoConcept(1038)).RemovePair(pair);

                pair = ((PairableScndCnpValue)this.DoConcept(1039)).Pairs.Where(x => x.From == startShift).FirstOrDefault();
                ((PairableScndCnpValue)this.DoConcept(1039)).RemovePair(pair);

                pair = ((PairableScndCnpValue)this.DoConcept(1040)).Pairs.Where(x => x.From == startShift).FirstOrDefault();
                ((PairableScndCnpValue)this.DoConcept(1040)).RemovePair(pair);

                pair = ((PairableScndCnpValue)this.DoConcept(1041)).Pairs.Where(x => x.From == startShift).FirstOrDefault();
                ((PairableScndCnpValue)this.DoConcept(1041)).RemovePair(pair);

                pair = ((PairableScndCnpValue)this.DoConcept(1042)).Pairs.Where(x => x.From == startShift).FirstOrDefault();
                ((PairableScndCnpValue)this.DoConcept(1042)).RemovePair(pair);

            }
            GetLog(MyRule, " After Execute State:", 1003, 1008, 1038, 1039, 1040, 1041, 1042);
        }

        /// <summary>قانون مرخصي 22-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي هشتاد و نه-89 درنظر گرفته شده است</remarks>
        public virtual void R89(AssignedRule MyRule)
        {
            //1093 تعداد بازهای مرخصی ساعتی
            //1003 مفهوم مرخصي استحقاقي ساعتی
            //1081 مفهوم مرخصي استحقاقي ساعتی خارج از شیفت
            //1083 حداکثر تعداد مرخصی ساعتی در ماه
            if (this.DoConcept(1081).Value > 0)
            {
                GetLog(MyRule, " Before Execute State:", 1003, 4002, 1081, 1092, 1093);
                ProceedTraffic ProceedTraffic = this.Person.GetProceedTraficByDate(this.RuleCalculateDate);
                BaseShift shift = this.Person.GetShiftByDate(this.RuleCalculateDate);
                foreach (IPair pair in ((PairableScndCnpValue)this.DoConcept(1081)).Pairs)
                {
                    //سقف تعداد مرخصی ساعتی در ماه اعمال میگردد 
                    if (this.DoConcept(1092).Value + 1 > this.DoConcept(1083).Value)
                    {
                        break;
                    }
                    bool weSawHim = false;
                    //before shift
                    if (pair.To <= shift.PastedPairs.From)
                    {
                        if (ProceedTraffic.Pairs.Where(x => x.From <= pair.From).Count() > 0)
                        {
                            weSawHim = true;
                        }
                    }
                    //after shift
                    else if (pair.From >= shift.PastedPairs.To)
                    {
                        if (ProceedTraffic.Pairs.Where(x => x.From >= pair.To).Count() > 0)
                        {
                            weSawHim = true;
                        }
                    }
                    //between shift
                    else
                    {
                        if (ProceedTraffic.Pairs.Where(x => x.To <= pair.From).Count() > 0
                            &&
                            ProceedTraffic.Pairs.Where(x => x.From >= pair.From).Count() > 0)
                        {
                            weSawHim = true;
                        }
                    }
                    if (weSawHim)
                    {
                        int validLeave = pair.Value;
                        this.Person.AddUsedLeave(this.RuleCalculateDate, validLeave, null);
                        this.DoConcept(1093).Value += 1;
                        this.DoConcept(1092).Value += 1;
                        ((PairableScndCnpValue)this.DoConcept(1003)).AppendPair(pair);
                        ((PairableScndCnpValue)this.DoConcept(4002)).AppendPair(pair);
                    }
                }
                this.ReCalculate(13);
                GetLog(MyRule, " After Execute State:", 1003, 4002, 1081, 1093);
            }
        }

        /// <summary>قانون مرخصي 23-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي نود-90 درنظر گرفته شده است</remarks>
        public virtual void R90(AssignedRule MyRule)
        {
            //1005 مفهوم مرخصي استحقاقي روزانه           
            //حد نصاب نوبت کاري 10 90
            //تعداد نوبت کاري 10 74
            //142 زمان نوبت کاري 10
            //143 تعداد نوبت کاري 15
            //144 زمان نوبت کاري 15
            //145 تعداد نوبت کاري 20
            //146 زمان نوبت کاري 20
            //147 تعداد نوبت کاري 25
            //148 زمان نوبت کاري 25
            //149 تعداد نوبت کاري 35
            //150 زمان نوبت کاري 35           
            //1090 انواع مرخصی روزانه که حقوق تعلق میگیرد

            //نحوه ی استفاده از نوبت کاری باید بررسی شود
            throw new NotImplementedException();
            /*

            GetLog(MyRule, " Before Execute State:", 74, 142, 143, 144, 145, 146, 147, 148, 149, 150);

            if (this.Person.GetShiftByDate(this.RuleCalculateDate).NobatKari != ShiftNobatKari.NONE)
            {
                if (this.DoConcept(1090).Value > 0 &&
                    this.Person.GetShiftByDate(this.RuleCalculateDate).MinNobatKari <= this.DoConcept(2).Value)
                {
                    switch (this.Person.GetShiftByDate(this.RuleCalculateDate).NobatKari)
                    {
                        case ShiftNobatKari.A:
                            this.DoConcept(5005).Value = 1;
                            this.DoConcept(142).Value = this.DoConcept(2).Value;
                            break;
                        case ShiftNobatKari.B:
                            this.DoConcept(143).Value = 1;
                            this.DoConcept(144).Value = this.DoConcept(2).Value;
                            break;
                        case ShiftNobatKari.C:
                            this.DoConcept(145).Value = 1;
                            this.DoConcept(146).Value = this.DoConcept(2).Value;
                            break;
                        case ShiftNobatKari.D:
                            this.DoConcept(147).Value = 1;
                            this.DoConcept(148).Value = this.DoConcept(2).Value;
                            break;
                        case ShiftNobatKari.E:
                            this.DoConcept(149).Value = 1;
                            this.DoConcept(150).Value = this.DoConcept(2).Value;
                            break;
                    }
                }
            }
            GetLog(MyRule, " After Execute State:", 74, 142, 143, 144, 145, 146, 147, 148, 149, 150);
             */
        }

        /// <summary>قانون مرخصي 23-2</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي نود و يک-91 درنظر گرفته شده است</remarks>
        public virtual void R91(AssignedRule MyRule)
        {
            //1020 مفهوم مرخصي بايد با مجوز باشد 
            GetLog(MyRule, " Before Execute State:", 1020);
            this.DoConcept(1020).Value = 1;
            GetLog(MyRule, " After Execute State:", 1020);
        }

        /// <summary>قانون مرخصي 24-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي نود و يک-91 درنظر گرفته شده است</remarks>
        public virtual void R105(AssignedRule MyRule)
        {
            //1074 مفهوم مرخصی بی حقوق ساعتی ماهانه 
            GetLog(MyRule, " Before Execute State:", 1074);
            this.DoConcept(1074).Value += this.GetConcept(1074, this.RuleCalculateDate.AddMonths(-1)).Value;
            GetLog(MyRule, " After Execute State:", 1074);
        }

        /// <summary>قانون مرخصي 25-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي نود و دو-3021 درنظر گرفته شده است</remarks>
        public virtual void R92(AssignedRule MyRule)
        {
            //4002 مفهوم اضافه کار ساعتي
            //1029 مرخصی روزانه بی حقوق_44
            //1031 مرخصی روزانه بی حقوق_43
            //1037 مرخصی روزانه بی حقوق_45
            GetLog(MyRule, " Before Execute State:", 4002);
            bool state = false;
            if (MyRule["First", this.RuleCalculateDate].ToInt() == 43 && this.DoConcept(1031).Value > 0)
            {
                state = true;
            }
            else if (MyRule["First", this.RuleCalculateDate].ToInt() == 44 && this.DoConcept(1029).Value > 0)
            {
                state = true;
            }
            else if (MyRule["First", this.RuleCalculateDate].ToInt() == 45 && this.DoConcept(1037).Value > 0)
            {
                state = true;
            }
            if (state)
            {
                ((PairableScndCnpValue)this.DoConcept(4002)).DecreasePairFromLast(MyRule["Second", this.RuleCalculateDate].ToInt());
                this.ReCalculate(13);
            }
            GetLog(MyRule, " After Execute State:", 4002);
        }

        /// <summary>قانون مرخصي 26-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي نود و سه-93 درنظر گرفته شده است</remarks>
        public virtual void R93(AssignedRule MyRule)
        {
            GetLog(MyRule, " Before Execute State:", 1003);
            if (this.DoConcept(1066).Value > 0 || this.DoConcept(1068).Value > 0
                || this.DoConcept(1070).Value > 0 || this.DoConcept(1072).Value > 0)
            {
                this.DoConcept(1003).Value += MyRule["First", this.RuleCalculateDate].ToInt();
                this.Person.AddUsedLeave(this.RuleCalculateDate, MyRule["First", this.RuleCalculateDate].ToInt(), null);
            }
            GetLog(MyRule, " After Execute State:", 1003);
        }

        /// <summary>قانون مرخصي 27-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي نود و چهار-3023 درنظر گرفته شده است</remarks>
        public virtual void R94(AssignedRule MyRule)
        {
            //3004 مفهوم غيبت روزانه

            if (this.DoConcept(3004).Value > 0)
            {
                GetLog(MyRule, " Before Execute State:", 1003);
                this.DoConcept(1003).Value += MyRule["First", this.RuleCalculateDate].ToInt();
                this.Person.AddUsedLeave(this.RuleCalculateDate, MyRule["First", this.RuleCalculateDate].ToInt(), null);
                GetLog(MyRule, " After Execute State:", 1003);
            }
        }

        /// <summary>قانون مرخصي 28-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي نود و پنج-3024 درنظر گرفته شده است</remarks>
        public virtual void R95(AssignedRule MyRule)
        {
            //7 مفهوم کارکرددرروز
            //1003 مفهوم مرخصي استحقاقي ساعتي
            //1005 مفهوم مرخصي استحقاقي روزانه
            //308 جمع مرخصي استحقاقي ساعتي
            //6 کارکرد لازم

            #region استحقاقی
            // در کد قبلی (کامنت شده) مقدار مرجع برای مقایسه پارامتر دوم بوده
            // در صورتیکه باید مرخصی در روز C20 در نظر گرفته میشده
            GetLog(MyRule, " Before Execute State:", 1003, 1005);
            this.DoConcept(1003).Value = (this.DoConcept(1005).Value * this.DoConcept(6).Value) + this.DoConcept(1003).Value;
            this.DoConcept(1005).Value = 0;

            if (
                this.DoConcept(1003).Value >=
                    MyRule["First", this.RuleCalculateDate].ToInt() &&
                this.DoConcept(1003).Value <=
                    MyRule["Second", this.RuleCalculateDate].ToInt()
                )
            {
                this.DoConcept(1005).Value = 1;

                if (this.DoConcept(1003).Value >= this.DoConcept(1001).Value)
                    this.DoConcept(1003).Value = this.DoConcept(1003).Value % this.DoConcept(1001).Value;
                else ((PairableScndCnpValue)this.DoConcept(1003)).ClearPairs();// this.DoConcept(1003).Value = 0;

                this.ReCalculate(1090, 1095);
            }
            else
            {
                this.DoConcept(1005).Value = this.DoConcept(1003).Value / this.DoConcept(1001).Value;
                this.DoConcept(1003).Value = this.DoConcept(1003).Value % this.DoConcept(1001).Value;
            }
            #endregion

            #region استعلاجی
            if (this.DoConcept(1010).Value >= 1)
            {
                GetLog(MyRule, " Before Execute State:", 1010, 1008);
                if (this.DoConcept(6).Value >= MyRule["First", this.RuleCalculateDate].ToInt())
                {
                    if (this.DoConcept(6).Value <= MyRule["Second", this.RuleCalculateDate].ToInt())
                    {
                        this.DoConcept(1010).Value = 1;
                    }
                    else
                    {
                        this.DoConcept(1010).Value = 1;
                        this.DoConcept(1008).Value = this.DoConcept(6).Value - MyRule["Second", this.RuleCalculateDate].ToInt();
                    }
                }
                else
                {
                    this.DoConcept(1008).Value = this.DoConcept(6).Value;
                }

                GetLog(MyRule, " After Execute State:", 1010, 1008);
            }
            #endregion

            #region با حقوق 43
            if (this.DoConcept(1031).Value >= 1)
            {
                GetLog(MyRule, " Before Execute State:", 1031, 1038);
                if (this.DoConcept(6).Value >= MyRule["First", this.RuleCalculateDate].ToInt())
                {
                    if (this.DoConcept(6).Value <= MyRule["Second", this.RuleCalculateDate].ToInt())
                    {
                        this.DoConcept(1031).Value = 1;
                    }
                    else
                    {
                        this.DoConcept(1031).Value = 1;
                        this.DoConcept(1038).Value = this.DoConcept(6).Value - MyRule["Second", this.RuleCalculateDate].ToInt();
                    }
                }
                else
                {
                    this.DoConcept(1038).Value = this.DoConcept(6).Value;
                }

                GetLog(MyRule, " After Execute State:", 1031, 1038);
            }
            #endregion

            #region با حقوق 44
            if (this.DoConcept(1029).Value >= 1)
            {
                GetLog(MyRule, " Before Execute State:", 1029, 1039);
                if (this.DoConcept(6).Value >= MyRule["First", this.RuleCalculateDate].ToInt())
                {
                    if (this.DoConcept(6).Value <= MyRule["Second", this.RuleCalculateDate].ToInt())
                    {
                        this.DoConcept(1029).Value = 1;
                    }
                    else
                    {
                        this.DoConcept(1029).Value = 1;
                        this.DoConcept(1039).Value = this.DoConcept(6).Value - MyRule["Second", this.RuleCalculateDate].ToInt();
                    }
                }
                else
                {
                    this.DoConcept(1039).Value = this.DoConcept(6).Value;
                }

                GetLog(MyRule, " After Execute State:", 1029, 1039);
            }
            #endregion

            #region با حقوق 45
            if (this.DoConcept(1037).Value >= 1)
            {
                GetLog(MyRule, " Before Execute State:", 1040, 3037);
                if (this.DoConcept(6).Value >= MyRule["First", this.RuleCalculateDate].ToInt())
                {
                    if (this.DoConcept(6).Value <= MyRule["Second", this.RuleCalculateDate].ToInt())
                    {
                        this.DoConcept(1037).Value = 1;
                    }
                    else
                    {
                        this.DoConcept(1037).Value = 1;
                        this.DoConcept(1040).Value = this.DoConcept(6).Value - MyRule["Second", this.RuleCalculateDate].ToInt();
                    }
                }
                else
                {
                    this.DoConcept(1040).Value = this.DoConcept(6).Value;
                }

                GetLog(MyRule, " After Execute State:", 1040, 1037);
            }
            #endregion

            #region با حقوق 46
            if (this.DoConcept(1033).Value >= 1)
            {
                GetLog(MyRule, " Before Execute State:", 1041, 1033);
                if (this.DoConcept(6).Value >= MyRule["First", this.RuleCalculateDate].ToInt())
                {
                    if (this.DoConcept(6).Value <= MyRule["Second", this.RuleCalculateDate].ToInt())
                    {
                        this.DoConcept(1033).Value = 1;
                    }
                    else
                    {
                        this.DoConcept(1033).Value = 1;
                        this.DoConcept(1041).Value = this.DoConcept(6).Value - MyRule["Second", this.RuleCalculateDate].ToInt();
                    }
                }
                else
                {
                    this.DoConcept(1041).Value = this.DoConcept(6).Value;
                }

                GetLog(MyRule, " After Execute State:", 1041, 1033);
            }
            #endregion

            #region با حقوق 47
            if (this.DoConcept(1035).Value >= 1)
            {
                GetLog(MyRule, " Before Execute State:", 1035, 1042);
                if (this.DoConcept(6).Value >= MyRule["First", this.RuleCalculateDate].ToInt())
                {
                    if (this.DoConcept(6).Value <= MyRule["Second", this.RuleCalculateDate].ToInt())
                    {
                        this.DoConcept(1035).Value = 1;
                    }
                    else
                    {
                        this.DoConcept(1035).Value = 1;
                        this.DoConcept(1042).Value = this.DoConcept(6).Value - MyRule["Second", this.RuleCalculateDate].ToInt();
                    }
                }
                else
                {
                    this.DoConcept(1042).Value = this.DoConcept(6).Value;
                }

                GetLog(MyRule, " After Execute State:", 1035, 1042);
            }
            #endregion

            #region بی حقوق 31
            if (this.DoConcept(1064).Value >= 1)
            {
                GetLog(MyRule, " Before Execute State:", 1054, 1064);
                if (this.DoConcept(6).Value >= MyRule["First", this.RuleCalculateDate].ToInt())
                {
                    if (this.DoConcept(6).Value <= MyRule["Second", this.RuleCalculateDate].ToInt())
                    {
                        this.DoConcept(1064).Value = 1;
                    }
                    else
                    {
                        this.DoConcept(1064).Value = 1;
                        this.DoConcept(1054).Value = this.DoConcept(6).Value - MyRule["Second", this.RuleCalculateDate].ToInt();
                    }
                }
                else
                {
                    this.DoConcept(1054).Value = this.DoConcept(6).Value;
                }

                GetLog(MyRule, " After Execute State:", 1054, 1064);
            }
            #endregion

            #region بی حقوق 32
            // در کد قبلی (کامنت شده) مقدار مرجع برای مقایسه پارامتر دوم بوده
            // در صورتیکه باید مرخصی در روز C20 در نظر گرفته میشده
            GetLog(MyRule, " Before Execute State:", 1056, 1066);
            this.DoConcept(1056).Value = (this.DoConcept(1066).Value * this.DoConcept(6).Value) + this.DoConcept(1056).Value;
            this.DoConcept(1066).Value = 0;

            if (
                this.DoConcept(1056).Value >=
                    MyRule["First", this.RuleCalculateDate].ToInt() &&
                this.DoConcept(1056).Value <=
                    MyRule["Second", this.RuleCalculateDate].ToInt()
                )
            {
                this.DoConcept(1066).Value = 1;

                if (this.DoConcept(1056).Value >= this.DoConcept(1001).Value)
                    this.DoConcept(1056).Value = this.DoConcept(1056).Value % this.DoConcept(1001).Value;
                else this.DoConcept(1056).Value = 0;
            }
            else
            {
                this.DoConcept(1066).Value = this.DoConcept(1056).Value / this.DoConcept(1001).Value;
                this.DoConcept(1056).Value = this.DoConcept(1056).Value % this.DoConcept(1001).Value;
            }
            GetLog(MyRule, " After Execute State:", 1056, 1066);
            #endregion

            #region بی حقوق 33
            if (this.DoConcept(1068).Value >= 1)
            {
                GetLog(MyRule, " Before Execute State:", 1058, 1070);
                if (this.DoConcept(6).Value >= MyRule["First", this.RuleCalculateDate].ToInt())
                {
                    if (this.DoConcept(6).Value <= MyRule["Second", this.RuleCalculateDate].ToInt())
                    {
                        this.DoConcept(1068).Value = 1;
                    }
                    else
                    {
                        this.DoConcept(1068).Value = 1;
                        this.DoConcept(1058).Value = this.DoConcept(6).Value - MyRule["Second", this.RuleCalculateDate].ToInt();
                    }
                }
                else
                {
                    this.DoConcept(1058).Value = this.DoConcept(6).Value;
                }

                GetLog(MyRule, " After Execute State:", 1058, 1070);
            }
            #endregion

            #region بی حقوق 34
            if (this.DoConcept(1070).Value >= 1)
            {
                GetLog(MyRule, " Before Execute State:", 1060, 1070);
                if (this.DoConcept(6).Value >= MyRule["First", this.RuleCalculateDate].ToInt())
                {
                    if (this.DoConcept(6).Value <= MyRule["Second", this.RuleCalculateDate].ToInt())
                    {
                        this.DoConcept(1070).Value = 1;
                    }
                    else
                    {
                        this.DoConcept(1070).Value = 1;
                        this.DoConcept(1060).Value = this.DoConcept(6).Value - MyRule["Second", this.RuleCalculateDate].ToInt();
                    }
                }
                else
                {
                    this.DoConcept(1060).Value = this.DoConcept(6).Value;
                }

                GetLog(MyRule, " After Execute State:", 1060, 1070);
            }
            #endregion

            #region بی حقوق 35
            if (this.DoConcept(1072).Value >= 1)
            {
                GetLog(MyRule, " Before Execute State:", 1062, 1072);
                if (this.DoConcept(6).Value >= MyRule["First", this.RuleCalculateDate].ToInt())
                {
                    if (this.DoConcept(6).Value <= MyRule["Second", this.RuleCalculateDate].ToInt())
                    {
                        this.DoConcept(1072).Value = 1;
                    }
                    else
                    {
                        this.DoConcept(1072).Value = 1;
                        this.DoConcept(1062).Value = this.DoConcept(6).Value - MyRule["Second", this.RuleCalculateDate].ToInt();
                    }
                }
                else
                {
                    this.DoConcept(1062).Value = this.DoConcept(6).Value;
                }

                GetLog(MyRule, " After Execute State:", 1062, 1072);
            }
            #endregion


        }

        /// <summary>قانون مرخصي 29-2</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي نود و شش-3025 درنظر گرفته شده است</remarks>
        /// مرخصي 28-2: روش تبديل ساعت مرخصي به روزانه:هر .... ساعت معادل يک روز مرخصي
        public virtual void R96(AssignedRule MyRule)
        {
            int leaveInDay = MyRule["First", this.RuleCalculateDate].ToInt();
            if (this.DoConcept(1003).Value > leaveInDay)
            {
                GetLog(MyRule, " Before Execute State:", 1005, 1003);
                this.DoConcept(1005).Value += this.DoConcept(1003).Value / leaveInDay;
                this.DoConcept(1003).Value += this.DoConcept(1003).Value % leaveInDay;
                GetLog(MyRule, " After Execute State:", 1005, 1003);
            }

            if (this.DoConcept(1008).Value > leaveInDay)
            {
                GetLog(MyRule, " Before Execute State:", 1010, 1008);
                this.DoConcept(1010).Value += this.DoConcept(1008).Value / leaveInDay;
                this.DoConcept(1008).Value += this.DoConcept(1008).Value % leaveInDay;
                GetLog(MyRule, " After Execute State:", 1010, 1008);
            }

            if (this.DoConcept(1038).Value > leaveInDay)
            {
                GetLog(MyRule, " Before Execute State:", 1031, 1038);
                this.DoConcept(1031).Value += this.DoConcept(1038).Value / leaveInDay;
                this.DoConcept(1038).Value += this.DoConcept(1038).Value % leaveInDay;
                GetLog(MyRule, " After Execute State:", 1031, 1038);
            }

            if (this.DoConcept(1039).Value > leaveInDay)
            {
                GetLog(MyRule, " Before Execute State:", 1029, 1039);
                this.DoConcept(1029).Value += this.DoConcept(1039).Value / leaveInDay;
                this.DoConcept(1039).Value += this.DoConcept(1039).Value % leaveInDay;
                GetLog(MyRule, " After Execute State:", 1029, 1039);
            }

            if (this.DoConcept(1040).Value > leaveInDay)
            {
                GetLog(MyRule, " Before Execute State:", 1037, 1040);
                this.DoConcept(1037).Value += this.DoConcept(1040).Value / leaveInDay;
                this.DoConcept(1040).Value += this.DoConcept(1040).Value % leaveInDay;
                GetLog(MyRule, " After Execute State:", 1037, 1040);
            }

            if (this.DoConcept(1041).Value > leaveInDay)
            {
                GetLog(MyRule, " Before Execute State:", 1033, 1041);
                this.DoConcept(1033).Value += this.DoConcept(1041).Value / leaveInDay;
                this.DoConcept(1041).Value += this.DoConcept(1041).Value % leaveInDay;
                GetLog(MyRule, " After Execute State:", 1033, 1041);
            }

            if (this.DoConcept(1042).Value > leaveInDay)
            {
                GetLog(MyRule, " Before Execute State:", 1035, 1042);
                this.DoConcept(1035).Value += this.DoConcept(1042).Value / leaveInDay;
                this.DoConcept(1042).Value += this.DoConcept(1042).Value % leaveInDay;
                GetLog(MyRule, " After Execute State:", 1035, 1042);
            }

            if (this.DoConcept(1054).Value > leaveInDay)
            {
                GetLog(MyRule, " Before Execute State:", 1054, 1064);
                this.DoConcept(1064).Value += this.DoConcept(1054).Value / leaveInDay;
                this.DoConcept(1054).Value += this.DoConcept(1054).Value % leaveInDay;
                GetLog(MyRule, " After Execute State:", 1054, 1064);
            }

            if (this.DoConcept(1056).Value > leaveInDay)
            {
                GetLog(MyRule, " Before Execute State:", 1056, 1066);
                this.DoConcept(1066).Value += this.DoConcept(1056).Value / leaveInDay;
                this.DoConcept(1056).Value += this.DoConcept(1056).Value % leaveInDay;
                GetLog(MyRule, " After Execute State:", 1056, 1066);
            }

            if (this.DoConcept(1058).Value > leaveInDay)
            {
                GetLog(MyRule, " Before Execute State:", 1058, 1068);
                this.DoConcept(1068).Value += this.DoConcept(1058).Value / leaveInDay;
                this.DoConcept(1058).Value += this.DoConcept(1058).Value % leaveInDay;
                GetLog(MyRule, " After Execute State:", 1058, 1068);
            }

            if (this.DoConcept(1060).Value > leaveInDay)
            {
                GetLog(MyRule, " Before Execute State:", 1060, 1070);
                this.DoConcept(1070).Value += this.DoConcept(1060).Value / leaveInDay;
                this.DoConcept(1060).Value += this.DoConcept(1060).Value % leaveInDay;
                GetLog(MyRule, " After Execute State:", 1060, 1070);
            }

            if (this.DoConcept(1062).Value > leaveInDay)
            {
                GetLog(MyRule, " Before Execute State:", 1062, 1072);
                this.DoConcept(1072).Value += this.DoConcept(1062).Value / leaveInDay;
                this.DoConcept(1062).Value += this.DoConcept(1062).Value % leaveInDay;
                GetLog(MyRule, " After Execute State:", 1062, 1072);
            }
        }

        /// <summary>قانون فراخواننده ی اصلاح «نتیجه مرخصی محاسبه شده» در هر روز"</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي يکصدو شش-106 درنظر گرفته شده است</remarks>
        public virtual void R106(AssignedRule MyRule)
        {
            this.Person.VerifyRemainLeave(this.RuleCalculateDate);
        }

        /// <summary>
        /// اعمال بازخريد مرخصي ها
        /// </summary>
        /// <param name="MyRule"></param>
        public virtual void R107(AssignedRule MyRule)
        {
            Permit permit = this.Person.GetPermitByDate(this.RuleCalculateDate, EngEnvironment.GetPrecard(Precards.DailyLeave6));
            if (permit != null && permit.Value == 1)
            {
                int leaveInDay = this.DoConcept(1001, this.RuleCalculateDate).Value;
                var remain = this.Person.GetRemainLeave(this.RuleCalculateDate);
                var souldDecrease = Operation.Minimum(remain, leaveInDay);

                if (souldDecrease > 0)
                    this.Person.AddUsedLeave(this.RuleCalculateDate, souldDecrease, permit);

            }
        }

        #endregion

        #region قوانين ماموريت

        /// <summary>ماموريت 1-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي يکصدوبيست و يک-3032 درنظر گرفته شده است</remarks>
        public virtual void R121(AssignedRule MyRule)
        {
            //ماموريت روزانه ماهانه 2006
            //ماموريت ساعتي ماهانه 2007
            //ماموريت درروز 2001
            //2006 ماموريت روزانه ماهانه
            GetLog(MyRule, " Before Execute State:", 2006, 2007);
            if (this.DoConcept(2007).Value > this.DoConcept(2001).Value)
            {
                this.DoConcept(2006).Value += this.DoConcept(2007).Value /
                                                            this.DoConcept(2001).Value;
                this.DoConcept(2007).Value = this.DoConcept(2007).Value %
                                                                        this.DoConcept(2001).Value;
            }
            GetLog(MyRule, " After Execute State:", 2006, 2007);
        }

        /// <summary>ماموريت 2-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي يکصدوبيست ودو-3033 درنظر گرفته شده است</remarks>
        public virtual void R122(AssignedRule MyRule)
        {
            //4 کارکردخالص روزانه
            //ماموريت روزانه 2005
            //2008 ماموريت خالص شبانه روزی
            //ماموريت شبانه روزي سالانه 2009
            //ماموريت روزانه سالانه 2010
            //سقف تعداد ماموريت روزانه و شبانه روزي در سال 2011
            //3004 غيبت روزانه

            if (this.DoConcept(2009).Value +
                this.DoConcept(2010).Value > MyRule["MaxMissionCount", this.RuleCalculateDate].ToInt())
            {
                GetLog(MyRule, " Before Execute State:", 2, 13, 4, 2008, 2009, 2005, 3004);
                this.DoConcept(2005).Value = 0;
                this.DoConcept(2008).Value = 0;
                this.DoConcept(2).Value = 0;
                this.DoConcept(4).Value = 0;
                this.ReCalculate(13);
                if (this.DoConcept(6).Value > 0 && this.DoConcept(1).Value > 0)
                {
                    this.DoConcept(3004).Value = 1;
                }
                this.ReCalculate(2009, 2010);
                GetLog(MyRule, " After Execute State:", 2, 13, 4, 2008, 2009, 2005, 3004);
            }
        }

        /// <summary>ماموريت 3-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي يکصدوبيست وسه-123 درنظر گرفته شده است</remarks>
        public virtual void R123(AssignedRule MyRule)
        {
            throw new Exception("در قانون مربوطه بصورت پارامتر ارسال شد  , از رده خارج");
            //2023 مجموع ماموريت ساعتي
            //کارکردخالص ساعتي 2
            //4 کارکردخالص روزانه
            //13 کارکرد ناخالص ساعتی
            //ماموريت خالص روزانه 2003
            //348 ماموریت به کارکردخالص اضافه شود
            //ماموريت درروز 2001
            //7 کارکرد در روز
            GetLog(MyRule, " Before Execute State:", 2, 4, 13, 2001, 4002);
            if (!EngEnvironment.HasCalendar(this.RuleCalculateDate, "1", "2"))
            {
                if (this.DoConcept(2005).Value == 1)
                {
                    this.DoConcept(4).Value = 1;
                    if (this.DoConcept(6).Value > 0)
                    {
                        this.DoConcept(2).Value = this.DoConcept(6).Value;
                    }
                    //else //باید توسط قانون روز غیر کاری به کارکرد اضافه شود انجام گردد
                    //{
                    //    this.DoConcept(2).Value = this.DoConcept(7).Value;
                    //}
                    if (this.DoConcept(2).Value == 0)
                    {
                        this.DoConcept(4).Value = 0;
                    }
                }
                else
                {
                    int value = 0;
                    value = Operation.Intersect(this.Person.GetShiftByDate(this.RuleCalculateDate), this.DoConcept(2023)).Value;
                    if (value > 0)
                    {
                        if (this.Person.GetShiftByDate(this.RuleCalculateDate).ShiftType == ShiftTypesEnum.WORK)
                        {
                            this.DoConcept(2).Value += value;
                        }
                        else if (this.Person.GetShiftByDate(this.RuleCalculateDate).ShiftType == ShiftTypesEnum.OVERTIME)
                        {
                            ((PairableScndCnpValue)this.DoConcept(4002)).IncreaseValue(value);
                        }
                    }
                }
                this.ReCalculate(13);
            }
            GetLog(MyRule, " After Execute State:", 2, 4, 13, 2001, 4002);
        }

        /// <summary>ماموريت 4-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي يکصدوبيست وپنج-125 درنظر گرفته شده است</remarks>
        public virtual void R125(AssignedRule MyRule)
        {
            //2023 مجموع ماموريت ساعتي
            //4 کارکردخالص روزانه
            //13 کارکرد ناخالص ساعتی
            //ماموريت خالص روزانه 2003
            //ماموريت درروز 2001
            //4002 اضافه کار مجاز
            //4003 اضافه کار غیرمجاز

            GetLog(MyRule, " Before Execute State:", 13);

            #region کارکرد خالص
            GetLog(MyRule, " Before Execute State:", 2, 4, 13, 2001, 4002);
            if (MyRule["First", this.RuleCalculateDate].ToInt() == 1 &&
                !EngEnvironment.HasCalendar(this.RuleCalculateDate, "1", "2"))
            {
                if (this.DoConcept(2005).Value == 1 && MyRule["Third", this.RuleCalculateDate].ToInt() == 1)
                {
                    this.DoConcept(4).Value = 1;
                    if (this.DoConcept(6).Value > 0)
                    {
                        this.DoConcept(2).Value = this.DoConcept(6).Value;
                    }
                    if (this.DoConcept(2).Value == 0)
                    {
                        this.DoConcept(4).Value = 0;
                    }
                }
                else if (MyRule["Forth", this.RuleCalculateDate].ToInt() == 1)
                {
                    int value = 0;
                    value = Operation.Intersect(this.Person.GetShiftByDate(this.RuleCalculateDate), this.DoConcept(2023)).Value;
                    if (value > 0)
                    {
                        if (this.Person.GetShiftByDate(this.RuleCalculateDate).ShiftType == ShiftTypesEnum.WORK)
                        {
                            this.DoConcept(2).Value += value;
                        }
                        else if (this.Person.GetShiftByDate(this.RuleCalculateDate).ShiftType == ShiftTypesEnum.OVERTIME)
                        {
                            ((PairableScndCnpValue)this.DoConcept(4002)).IncreaseValue(value);
                        }
                    }
                }
                this.ReCalculate(13);
            }
            GetLog(MyRule, " After Execute State:", 2, 4, 13, 2001, 4002);
            #endregion

            //اگر قانون 123 استفاده نشده است انگاه این قانون اجرا شود
            //جمله بالا اشتباه است زیرا در قانون بالا فقط داخل شیفت محاسبه میشود
            if (MyRule["Second", this.RuleCalculateDate].ToInt() == 1 &&
                MyRule["First", this.RuleCalculateDate].ToInt() == 0 &&
                !EngEnvironment.HasCalendar(this.RuleCalculateDate, "1", "2"))
            {
                if (this.DoConcept(2005).Value == 1 && MyRule["Third", this.RuleCalculateDate].ToInt() == 1)
                {
                    if (this.DoConcept(6).Value > 0)
                    {
                        this.DoConcept(13).Value += this.DoConcept(6).Value;
                    }
                    else
                    {
                        this.DoConcept(13).Value += this.DoConcept(7).Value;
                    }
                }
                else if (MyRule["Forth", this.RuleCalculateDate].ToInt() == 1)
                {
                    int value = 0;

                    value = this.DoConcept(2023).Value;

                    if (value > 0)
                    {
                        this.DoConcept(13).Value += value;
                    }
                }
            }
            else if (MyRule["Second", this.RuleCalculateDate].ToInt() == 1
                && !EngEnvironment.HasCalendar(this.RuleCalculateDate, "1", "2"))
            {//داخل شبفت در 123 محاسبه شده است
                if (this.DoConcept(2005).Value == 0)
                {
                    int value = 0;
                    // خارج شیفت به شرطی که قبلا در اضافه کار محاسبه نشده باشد
                    PairableScndCnpValue pairableScndCnpValue1 = Operation.Differance(this.DoConcept(2023), this.Person.GetShiftByDate(this.RuleCalculateDate));
                    PairableScndCnpValue pairableScndCnpValue2 = Operation.Differance(pairableScndCnpValue1, this.DoConcept(4002));
                    value = Operation.Differance(pairableScndCnpValue2, this.DoConcept(4003)).Value;
                    if (value > 0)
                    {
                        this.DoConcept(13).Value += value;
                    }
                }
            }
            GetLog(MyRule, " After Execute State:", 13);
        }

        /// <summary>ماموريت 5-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي يکصدوبيست وشش-126 درنظر گرفته شده است</remarks>
        /// ماموريت 5-1: تعطيلات بين ماموريت روزانه ماموريت محسوب شود
        public virtual void R126(AssignedRule MyRule)
        {
            throw new Exception("در قانون مربوطه بصورت پارامتر ارسال شد  , از رده خارج");
            //2048 تعطیلات غیر رسمی بین ماموریت,ماموریت محسوب شود

            GetLog(MyRule, " Before Execute State:", 2048);
            this.DoConcept(2048).Value = 1;
            GetLog(MyRule, " After Execute State:", 2048);
        }



        ///<summary>ماموريت 7-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي يکصدوبيست وهشت-128 درنظر گرفته شده است</remarks>
        public virtual void R128(AssignedRule MyRule)
        {
            throw new Exception("در قانون مربوطه بصورت پارامتر ارسال شد  , از رده خارج");
            //2047 تعطیلات رسمی بین ماموریت,ماموریت محسوب شود

            GetLog(MyRule, " Before Execute State:", 2047);
            this.DoConcept(2047).Value = 1;
            GetLog(MyRule, " After Execute State:", 2047);
        }

        ///<summary>ماموريت 8-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي يکصدوبيست و نه-129 درنظر گرفته شده است</remarks>
        public virtual void R129(AssignedRule MyRule)
        {
            throw new Exception("در قانون مربوطه بصورت پارامتر ارسال شد  , از رده خارج");
            //2050 تعطیلات رسمی بین ماموریت شبانه روزی,ماموریت شبانه روزی محسوب شود

            GetLog(MyRule, " Before Execute State:", 2050);
            this.DoConcept(2050).Value = 1;
            GetLog(MyRule, " After Execute State:", 2050);
        }

        /// <summary>ماموريت 9-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي يکصدوسي-5 درنظر گرفته شده است</remarks>
        public virtual void R130(AssignedRule MyRule)
        {
            throw new Exception("در قانون مربوطه بصورت پارامتر ارسال شد  , از رده خارج");
            //2049 روزهای غیر کاری بین ماموریت,ماموریت محسوب شود
            GetLog(MyRule, " Before Execute State:", 2049);
            this.DoConcept(2049).Value = 1;
            GetLog(MyRule, " After Execute State:", 2049);
        }


        ///<summary>قانون ماموريت 11-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي يکصدو سي و دو-3004 درنظر گرفته شده است</remarks>
        public virtual void R132(AssignedRule MyRule)
        {
            //ماموريت روزانه 2005
            //2008 ماموريت شبانه روزي
            //اضافه کارساعتي 56
            //ماموريت درروز 2001
            //7 کارکرد در روز
            if (this.DoConcept(2008).Value + this.DoConcept(2005).Value > 0 &&
                  this.Person.GetShiftByDate(this.RuleCalculateDate).Value == 0)
            {
                GetLog(MyRule, " Before Execute State:", 4002);
                ((PairableScndCnpValue)this.DoConcept(4002)).IncreaseValue(this.DoConcept(7).Value);
                GetLog(MyRule, " After Execute State:", 4002);
            }
        }

        ///<summary>قانون ماموريت 12-1</summary>
        /// <remarks>ماموریت ساعتی اول وقت با پیشکارت مجاز است</remarks>
        /// /// <remarks>این قانون بصورت عکس فعال میشود یعنی ما در حالت عادی ماموریت اول وقت میدهیم
        /// و در صورتی که این قانون تیک نخورده بود مامورینپت داده شده را پس میگیریم
        public virtual void R270(AssignedRule MyRule)
        {
            //2004  ماموریت ساعتی51 
            //2019 ماموریت ساعتی52
            //2020 ماموریت ساعتی53
            //2021 ماموریت ساعتی54
            //2022 ماموریت ساعتی55
            //مجموع ماموريت ساعتي 2023

            GetLog(MyRule, " Before Execute State:", 2004, 2019, 2020, 2021, 2022, 2023);
            if (this.Person.GetShiftByDate(this.RuleCalculateDate).Value > 0)
            {
                int startShift = this.Person.GetShiftByDate(this.RuleCalculateDate).PastedPairs.From;
                IPair pair = null;
                if (this.DoConcept(2004).Value > 0)
                {
                    pair = ((PairableScndCnpValue)this.DoConcept(2004)).Pairs.Where(x => x.From == startShift).FirstOrDefault();
                    ((PairableScndCnpValue)this.DoConcept(2004)).RemovePair(pair);
                    this.ReCalculate(2023);
                }
                if (this.DoConcept(2019).Value > 0)
                {
                    pair = ((PairableScndCnpValue)this.DoConcept(2019)).Pairs.Where(x => x.From == startShift).FirstOrDefault();
                    ((PairableScndCnpValue)this.DoConcept(2019)).RemovePair(pair);
                    this.ReCalculate(2023);
                }
                if (this.DoConcept(2020).Value > 0)
                {
                    pair = ((PairableScndCnpValue)this.DoConcept(2020)).Pairs.Where(x => x.From == startShift).FirstOrDefault();
                    ((PairableScndCnpValue)this.DoConcept(2020)).RemovePair(pair);
                    this.ReCalculate(2023);
                }
                if (this.DoConcept(2021).Value > 0)
                {
                    pair = ((PairableScndCnpValue)this.DoConcept(2021)).Pairs.Where(x => x.From == startShift).FirstOrDefault();
                    ((PairableScndCnpValue)this.DoConcept(2021)).RemovePair(pair);
                    this.ReCalculate(2023);
                }
                if (this.DoConcept(2022).Value > 0)
                {
                    pair = ((PairableScndCnpValue)this.DoConcept(2022)).Pairs.Where(x => x.From == startShift).FirstOrDefault();
                    ((PairableScndCnpValue)this.DoConcept(2022)).RemovePair(pair);
                    this.ReCalculate(2023);
                }
                if (pair != null && pair.Value > 0)
                {
                    ((PairableScndCnpValue)this.DoConcept(3028)).AppendPair(pair);
                }
            }
            GetLog(MyRule, " After Execute State:", 2004, 2019, 2020, 2021, 2022, 2023);

        }

        ///<summary>قانون ماموريت 13-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي يکصدو سي و سه-133 درنظر گرفته شده است</remarks>
        public virtual void R133(AssignedRule MyRule)
        {
            //ماموريت ساعتي 2004
            //4007 مفهوم اضافه کارساعتي بعد ازوقت           
            //4008 مفهوم اضافه کارساعتي قبل ازوقت
            //2012 مجوز ماموريت در ساعات غيرکاري           
            //4001 اضافه خالص کارساعتي
            //4002 اضافه کارساعتي
            //2023 مفهوم مجموع ماموريت ساعتي           
            //2028 مفهوم ماموریت خارج از شیفت در روز کاری

            GetLog(MyRule, " Before Execute State:", 2004, 4007, 2012, 4002, 2023);

            if (this.DoConcept(2028).Value > 0)
            {
                foreach (IPair pair in ((PairableScndCnpValue)this.DoConcept(2028)).Pairs)
                {
                    ((PairableScndCnpValue)this.DoConcept(4001))
                        .AppendPairs(Operation.Differance(pair, this.Person.GetShiftByDate(this.RuleCalculateDate)));

                    ((PairableScndCnpValue)this.DoConcept(4002))
                        .AppendPairs(Operation.Differance(pair, this.Person.GetShiftByDate(this.RuleCalculateDate)));


                    ((PairableScndCnpValue)this.DoConcept(2004)).AppendPair(pair);
                }
                this.ReCalculate(13, 2023, 4007, 4008);
            }

            if (this.Person.GetShiftByDate(this.RuleCalculateDate).Value == 0)
            {
                if (this.DoConcept(2023).Value > 0)
                {
                    ((PairableScndCnpValue)this.DoConcept(4001))
                        .AppendPairs(((PairableScndCnpValue)this.DoConcept(2023)).Pairs);

                    ((PairableScndCnpValue)this.DoConcept(4002))
                       .AppendPairs(((PairableScndCnpValue)this.DoConcept(2023)).Pairs);

                    this.ReCalculate(13, 2023, 4007, 4008);
                }
            }

            GetLog(MyRule, " After Execute State:", 2004, 4007, 2012, 4002, 2023);
        }

        ///<summary>قانون ماموريت 14-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي يکصدو سي و چهار-1021 درنظر گرفته شده است</remarks>
        public virtual void R134(AssignedRule MyRule)
        {
            //14 مفهوم شب
            //2012 ماموریت در استراحت بین وقت مجاز است
            //ماموريت دراستراحت بين وقت 2013
            //اضافه کارساعتي 4002
            //4012 اضافه کارساعتي مجازشب
            //2023 مفهوم مجموع ماموريت ساعتي
            GetLog(MyRule, " Before Execute State:", 4002, 2004, 2019, 2020, 2021, 2022, 2023);
            if (this.DoConcept(2012).Value == 0)
            {
                ((PairableScndCnpValue)this.DoConcept(2004)).AppendPairs(Operation.Intersect(this.DoConcept(2004), this.DoConcept(2013)));
                ((PairableScndCnpValue)this.DoConcept(2019)).AppendPairs(Operation.Intersect(this.DoConcept(2019), this.DoConcept(2013)));
                ((PairableScndCnpValue)this.DoConcept(2020)).AppendPairs(Operation.Intersect(this.DoConcept(2020), this.DoConcept(2013)));
                ((PairableScndCnpValue)this.DoConcept(2021)).AppendPairs(Operation.Intersect(this.DoConcept(2021), this.DoConcept(2013)));
                ((PairableScndCnpValue)this.DoConcept(2022)).AppendPairs(Operation.Intersect(this.DoConcept(2022), this.DoConcept(2013)));
                ((PairableScndCnpValue)this.DoConcept(4002)).AppendPairs(((PairableScndCnpValue)this.DoConcept(2013)).Pairs);
                this.ReCalculate(13, 4012, 2023);
            }
            GetLog(MyRule, " After Execute State:", 4002, 2004, 2019, 2020, 2021, 2022, 2023);
        }

        ///<summary>قانون ماموريت 15-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي يکصدو سي و پنج-1022 درنظر گرفته شده است</remarks>
        public virtual void R135(AssignedRule MyRule)
        {
            //2005 مجموع ماموريت روزانه
            //2008 مجموع ماموریت شبانه روزی
            //حد نصاب نوبت کاري 10 90
            //تعداد نوبت کاري 10 74
            //142 زمان نوبت کاري 10
            //143 تعداد نوبت کاري 15
            //144 زمان نوبت کاري 15
            //145 تعداد نوبت کاري 20
            //146 زمان نوبت کاري 20
            //147 تعداد نوبت کاري 25
            //148 زمان نوبت کاري 25
            //149 تعداد نوبت کاري 35
            //150 زمان نوبت کاري 35 

            //نحوه ی استفاده از نوبت کاری باید بررسی شود
            throw new NotImplementedException();
            /*
            GetLog(MyRule, " Before Execute State:", 2, 74, 142, 143, 144, 145, 146, 147, 148, 149, 150);
            if (this.DoConcept(2005).Value > 0 || this.DoConcept(2008).Value > 0)
            {
                if (this.Person.GetShiftByDate(this.RuleCalculateDate).NobatKari != ShiftNobatKari.NONE)
                {
                    if (this.Person.GetShiftByDate(this.RuleCalculateDate).MinNobatKari <= this.DoConcept(2).Value)
                    {
                        switch (this.Person.GetShiftByDate(this.RuleCalculateDate).NobatKari)
                        {
                            case ShiftNobatKari.A:
                                this.DoConcept(5005).Value = 1;
                                this.DoConcept(142).Value = this.DoConcept(2).Value;
                                break;
                            case ShiftNobatKari.B:
                                this.DoConcept(143).Value = 1;
                                this.DoConcept(144).Value = this.DoConcept(2).Value;
                                break;
                            case ShiftNobatKari.C:
                                this.DoConcept(145).Value = 1;
                                this.DoConcept(146).Value = this.DoConcept(2).Value;
                                break;
                            case ShiftNobatKari.D:
                                this.DoConcept(147).Value = 1;
                                this.DoConcept(148).Value = this.DoConcept(2).Value;
                                break;
                            case ShiftNobatKari.E:
                                this.DoConcept(149).Value = 1;
                                this.DoConcept(150).Value = this.DoConcept(2).Value;
                                break;
                        }
                    }
                }
            }
            GetLog(MyRule, " After Execute State:", 2, 74, 142, 143, 144, 145, 146, 147, 148, 149, 150);
             * */
        }

        ///<summary>قانون ماموريت 16-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي يکصدو سي و شش-136 درنظر گرفته شده است</remarks>
        public virtual void R136(AssignedRule MyRule)
        {
            //ماموريت ساعتي 2004
            //مجوز ماموريت در ساعات غيرکاري 2012
            //اضافه کارساعتي 4002
            //حضور 1
            //ماموريت روزانه 2005
            GetLog(MyRule, " Before Execute State:", 4002);
            if (this.Person.GetShiftByDate(this.RuleCalculateDate).Value == 0)
                if (this.DoConcept(2005).Value > 0 || this.DoConcept(2008).Value > 0)
                    if (this.DoConcept(1).Value > 0)
                    {

                        ((PairableScndCnpValue)this.DoConcept(4002)).AddPairs(this.DoConcept(1));
                        this.ReCalculate(13);
                        //نباید از اینجا به بعد کارکرد ناخالص دوباره محاسبه شود تا
                        //در قانون ماموریت به کارکرد ناخالص اضافه شود اختلال ایجاد نشود
                    }
            GetLog(MyRule, " After Execute State:", 4002);

        }

        ///<summary>قانون ماموريت 17-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي يکصدو سي و هفت-137 درنظر گرفته شده است</remarks>
        public virtual void R137(AssignedRule MyRule)
        {
            this.DoConcept(2027).Value = 1;
        }

        ///<summary>قانون ماموريت 18-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي يکصدو سي و هشت-138 درنظر گرفته شده است</remarks>
        public virtual void R138(AssignedRule MyRule)
        {
            //مجموع ماموريت روزانه 2005
            //2008 مجموع ماموریت شبانه روزی
            //تقويم تعطيل رسمي 1
            //تعطيل غير رسمي 2
            //ماموريت درروز 2001
            //1005 مرخصی استحقاقی روزانه
            if (EngEnvironment.HasCalendar(this.RuleCalculateDate, "1", "2"))
            {
                if (this.DoConcept(2005).Value > 0 || this.DoConcept(2008).Value > 0)
                {
                    GetLog(MyRule, " Before Execute State:", 1005);
                    this.DoConcept(1005).Value -= 1;
                    this.Person.AddRemainLeave(this.RuleCalculateDate, this.DoConcept(2001).Value);
                    GetLog(MyRule, " After Execute State:", 1005);
                }
            }
        }

        ///<summary>قانون ماموريت 19-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي يکصدو سي و نه-139 درنظر گرفته شده است</remarks>
        public virtual void R139(AssignedRule MyRule)
        {
            throw new NotImplementedException("بررسی شود");
            GetLog(MyRule, " Before Execute State:", 2004, 2019, 2020, 2021, 2022, 2031, 2032, 2033, 2034, 2035);
            if (this.Person.GetShiftByDate(this.RuleCalculateDate).Value == 0)
            {
                if (this.DoConcept(2031).Value > 0)
                {
                    this.DoConcept(2004).Value = MyRule["First", this.RuleCalculateDate].ToInt();
                    this.DoConcept(2031).Value = 0;
                }
                if (this.DoConcept(2032).Value > 0)
                {
                    this.DoConcept(2019).Value = MyRule["First", this.RuleCalculateDate].ToInt();
                    this.DoConcept(2032).Value = 0;
                }
                if (this.DoConcept(2033).Value > 0)
                {
                    this.DoConcept(2020).Value = MyRule["First", this.RuleCalculateDate].ToInt();
                    this.DoConcept(2033).Value = 0;
                }
                if (this.DoConcept(2034).Value > 0)
                {
                    this.DoConcept(2021).Value = MyRule["First", this.RuleCalculateDate].ToInt();
                    this.DoConcept(2034).Value = 0;
                }
                if (this.DoConcept(2035).Value > 0)
                {
                    this.DoConcept(2022).Value = MyRule["First", this.RuleCalculateDate].ToInt();
                    this.DoConcept(2035).Value = 0;
                }
                if (this.DoConcept(2041).Value > 0)
                {
                    this.DoConcept(2004).Value = MyRule["First", this.RuleCalculateDate].ToInt();
                    this.DoConcept(2041).Value = 0;
                }
                if (this.DoConcept(2042).Value > 0)
                {
                    this.DoConcept(2019).Value = MyRule["First", this.RuleCalculateDate].ToInt();
                    this.DoConcept(2042).Value = 0;
                }
                if (this.DoConcept(2043).Value > 0)
                {
                    this.DoConcept(2020).Value = MyRule["First", this.RuleCalculateDate].ToInt();
                    this.DoConcept(2043).Value = 0;
                }
                if (this.DoConcept(2044).Value > 0)
                {
                    this.DoConcept(2021).Value = MyRule["First", this.RuleCalculateDate].ToInt();
                    this.DoConcept(2044).Value = 0;
                }
                if (this.DoConcept(2045).Value > 0)
                {
                    this.DoConcept(2022).Value = MyRule["First", this.RuleCalculateDate].ToInt();
                    this.DoConcept(2045).Value = 0;
                }
                this.ReCalculate(2005, 2008, 2023);
            }
            GetLog(MyRule, " After Execute State:", 2004, 2019, 2020, 2021, 2022, 2031, 2032, 2033, 2034, 2035);
        }

        ///<summary>قانون ماموريت 20-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي يکصدو چهل-140 درنظر گرفته شده است</remarks>
        public virtual void R140(AssignedRule MyRule)
        {
            //ماموريت روزانه 2005
            //ماموريت ساعتي 2004
            GetLog(MyRule, " Before Execute State:", 2004, 2005, 3028, 2023, 2031);
            if (this.DoConcept(2005).Value > 0)
            {
                if (this.DoConcept(6).Value >= MyRule["First", this.RuleCalculateDate].ToInt())
                {
                    this.DoConcept(2031).Value = 1;
                    if (this.DoConcept(6).Value > MyRule["Second", this.RuleCalculateDate].ToInt())
                    {
                        this.DoConcept(2004).Value = this.DoConcept(6).Value - this.DoConcept(2001).Value;
                    }
                }
                else
                {
                    this.DoConcept(2004).Value = this.DoConcept(6).Value;
                }
                this.DoConcept(3028).Value = 0;
                this.ReCalculate(2023, 2005);
            }
            GetLog(MyRule, " After Execute State:", 2004, 2005, 3028, 2023, 2031);

        }

        ///<summary>قانون ماموريت 20-2</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي يکصدو چهل-141 درنظر گرفته شده است</remarks>
        /// اموريت 20-2: روش تبديل ساعت ماموريت به روزانه: هر .... ساعت معادل يک روز ماموريت
        public virtual void R141(AssignedRule MyRule)
        {
            //ماموريت روزانه 2005
            //ماموريت ساعتي 2004
            //2031 مفهوم ماموریت روزانه_61

            GetLog(MyRule, " Before Execute State:", 2004, 2005, 2031, 3028, 2023);
            if (this.DoConcept(2004).Value > 0)
            {
                this.DoConcept(2031).Value += this.DoConcept(2004).Value / MyRule["First", this.RuleCalculateDate].ToInt();
                this.DoConcept(2004).Value = this.DoConcept(2004).Value % MyRule["First", this.RuleCalculateDate].ToInt();
                PairableScndCnpValue.AddPairToScndCnpValue(new PairableScndCnpValuePair(0, this.DoConcept(2004).Value), this.DoConcept(2004));
                this.DoConcept(3028).Value = 0;
                this.ReCalculate(2023, 2005);
            }
            GetLog(MyRule, " After Execute State:", 2004, 2005, 2031, 3028, 2023);

        }

        ///<summary>قانون ماموريت 20-3</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي يکصدو چهل-142 درنظر گرفته شده است</remarks>
        public virtual void R142(AssignedRule MyRule)
        {
            //ماموريت روزانه 2005
            //اضافه کارساعتي 4002
            //ماموريت ساعتي 2004


            GetLog(MyRule, " Before Execute State:", 2005, 3028, 4002, 2023, 2031);
            if (this.DoConcept(2005).Value > 0)
            {
                this.DoConcept(2031).Value = 1;
                if (MyRule["First", this.RuleCalculateDate].ToInt() > this.DoConcept(6).Value)
                {
                    ((PairableScndCnpValue)this.DoConcept(4002)).IncreaseValue(MyRule["First", this.RuleCalculateDate].ToInt() - this.DoConcept(6).Value);
                }
                this.DoConcept(3028).Value = 0;
                this.ReCalculate(2023, 2005);
            }
            GetLog(MyRule, " After Execute State:", 2005, 3028, 4002, 2023, 2031);

        }

        #endregion

        #region قوانين کم کاري

        /// <summary>قانون کم کاري 1-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي سي و هشت-38 درنظر گرفته شده است</remarks>
        public virtual void R38(AssignedRule MyRule)
        {

            //کارکردخالص ساعتي 2
            //13 کارکردناخالص

            //غيبت خالص ساعتي 3001
            //3020 غیبت مجاز ساعتی
            //تاخير ساعتي مجاز 3021
            //3028 غیبت غیر مجاز ساعتی
            //3029 تاخير ساعتي غيرمجاز


            //تاخيرخالص ساعتي 3008


            //تعداد بازه های تاخیر 3038

            //1002 مرخصي خالص استحقاقي ساعتي 
            //2002 ماموريت خالص ساعتي
            //1056 مرخصی بی حقوق ساعتی 12

            //1025 مرخصی با حقوق ساعتی_دادگاه-ورزشی
            //1027 مرخصی با حقوق ساعتی

            //3002 کل تاخیر یا تعجیل بیش از حد مجاز روزانه غیبت حساب شود

            GetLog(MyRule, " Before Execute State:", 2, 3008, 3028, 3020, 3021, 3029, 3038, 1002, 2002);
            this.DoConcept(1002);
            this.DoConcept(1056);
            this.DoConcept(2002);

            if (this.DoConcept(3002).Value == 1 && this.DoConcept(3029).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                GetLog(MyRule, " After Execute State:", 2, 3008, 3028, 3020, 3021, 3029, 3038, 1002, 2002);
                return;
            }

            if (Operation.Intersect(this.DoConcept(3029), this.DoConcept(3028)).Value > 0 && this.DoConcept(1).Value > 0)
            {
                int StartShift = this.Person.GetShiftByDate(this.RuleCalculateDate).Pairs.OrderBy(x => x.From).First().From;
                IPair StartMissionPair = ((PairableScndCnpValue)this.DoConcept(2002)).Pairs.OrderBy(x => x.From).FirstOrDefault();
                if (StartMissionPair != null && StartMissionPair.From - this.DoConcept(3029).Value == StartShift)
                {
                    this.DoConcept(3021).Value = Operation.Minimum(this.DoConcept(3029).Value, MyRule["Second", this.RuleCalculateDate].ToInt());
                    ((PairableScndCnpValue)this.DoConcept(3029)).DecreasePairFromFirst(this.DoConcept(3021).Value);
                    this.DoConcept(2).Value += this.DoConcept(3021).Value;

                    this.ReCalculate(13, 3020, 3028);
                }
                else
                {
                    #region اگر بخشی از غیبت اول وقت(تاخیر) را مرخصی گرفته است مابقی تاخیر نباید به مجاز تبدیل شود

                    int ShiftStartWithAllowedDelay = this.Person.GetShiftByDate(this.RuleCalculateDate).Pairs.OrderBy(x => x.From).FirstOrDefault().From + MyRule["First", this.RuleCalculateDate].ToInt();
                    if (((PairableScndCnpValue)this.DoConcept(1002)).Pairs.Where(x => x.From == ShiftStartWithAllowedDelay).Count() > 0)
                    {
                        GetLog(MyRule, " After Execute State:", 2, 3008, 3028, 3020, 3021, 3029, 3038, 1002, 2002);
                        return;
                    }

                    #endregion

                    this.DoConcept(3021).Value = Operation.Minimum(this.DoConcept(3029).Value, MyRule["First", this.RuleCalculateDate].ToInt());
                    ((PairableScndCnpValue)this.DoConcept(3029)).DecreasePairFromFirst(this.DoConcept(3021).Value);
                    this.DoConcept(2).Value += this.DoConcept(3021).Value;

                    this.ReCalculate(13, 3020, 3028);

                    if (this.DoConcept(3029).Value > 0)
                        this.DoConcept(3038).Value = 1;
                }
            }
            GetLog(MyRule, " After Execute State:", 2, 3008, 3028, 3020, 3021, 3029, 3038, 1002, 2002);
        }

        /// <summary>قانون کم کاري 1-2</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي سي و نه-39 درنظر گرفته شده است</remarks>
        public virtual void R39(AssignedRule MyRule)
        {
            //کارکردخالص ساعتي 2
            //غيبت خالص ساعتي 3001

            //مدت تعجيل مجاز 3012

            //تعجيل ساعتي مجاز 3022
            //تعجيل ساعتي غيرمجاز 3030
            //3036 تعداد بازه های تعجیل

            //1002 مرخصي خالص استحقاقي ساعتي 
            //2002 ماموريت خالص ساعتي
            //1056 مرخصی بی حقوق ساعتی 12

            GetLog(MyRule, " Before Execute State:", 2, 3020, 3022, 3028, 3030, 3036, 1002, 2002);
            this.DoConcept(1002);
            this.DoConcept(1056);
            this.DoConcept(2002);
            if (this.DoConcept(3002).Value == 1 && this.DoConcept(3030).Value > this.DoConcept(3012).Value)
                return;
            if (Operation.Intersect(this.DoConcept(3030), this.DoConcept(3028)).Value > 0 && this.DoConcept(1).Value > 0)
            {

                this.DoConcept(3022).Value = Operation.Minimum(this.DoConcept(3030).Value,
                                                                                this.DoConcept(3012).Value);
                ((PairableScndCnpValue)this.DoConcept(3030)).DecreasePairFromLast(this.DoConcept(3022).Value);
                this.DoConcept(2).Value += this.DoConcept(3022).Value;

                this.ReCalculate(13, 3020, 3028);

                if (this.DoConcept(3030).Value > 0)
                    this.DoConcept(3036).Value = 1;

            }
            GetLog(MyRule, " After Execute State:", 2, 3020, 3022, 3030, 3028, 3036, 1002, 2002);
        }

        /// <summary>قانون کم کاري 1-3</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي چهل-3006 درنظر گرفته شده است</remarks>
        public virtual void R40(AssignedRule MyRule)
        {
            //کارکردخالص ساعتي 2
            //غيبت خالص ساعتي 3001

            //مدت غيبت بين وقت مجاز 3017

            //غيبت بين وقت ساعتي مجاز 3023
            //غيبت بين وقت ساعتي غيرمجاز 3031

            //1002 مرخصي خالص استحقاقي ساعتي 
            //1056 مرخصی بی حقوق ساعتی 12
            //2002 ماموريت خالص ساعتي

            GetLog(MyRule, " Before Execute State:", 2, 3023, 3031, 1002, 2002);
            this.DoConcept(1002);
            this.DoConcept(1056);
            this.DoConcept(2002);

            if (Operation.Intersect(this.DoConcept(3031), this.DoConcept(3028)).Value > 0 && this.DoConcept(1).Value > 0)
            {
                this.DoConcept(3023).Value = Operation.Minimum(this.DoConcept(3031).Value,
                                                                                this.DoConcept(3017).Value);
                ((PairableScndCnpValue)this.DoConcept(3031)).DecreasePairFromFirst(this.DoConcept(3023).Value);

                this.DoConcept(2).Value += this.DoConcept(3023).Value;
                this.ReCalculate(13, 3020, 3028);
            }
            GetLog(MyRule, " After Execute State:", 2, 3023, 3031, 1002, 2002);
        }

        /// <summary>قانون کم کاري 2-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي چهل و يک-41 درنظر گرفته شده است</remarks>
        public virtual void R41(AssignedRule MyRule)
        {
            //کارکردخالص ساعتي ماهانه 8

            //تاخير ساعتي مجاز ماهانه 3024
            //3032 تاخير ساعتي غيرمجاز ماهانه

            //غیبت ساعتی مجاز ماهانه 3026 
            //3034 غیبت ساعتی غیرمجاز ماهانه


            if (MyRule["First", this.RuleCalculateDate].ToInt() <= this.DoConcept(3024).Value)
            {
                GetLog(MyRule, " Before Execute State:", 8, 3024, 3026, 3032, 3034);
                int tmp = this.DoConcept(3024).Value - MyRule["First", this.RuleCalculateDate].ToInt();
                this.DoConcept(8).Value -= tmp;
                this.DoConcept(3026).Value -= tmp;
                this.DoConcept(3024).Value -= tmp;

                this.DoConcept(3034).Value += tmp;
                this.DoConcept(3032).Value += tmp;

                GetLog(MyRule, " After Execute State:", 8, 3024, 3026, 3032, 3034);
            }
        }

        /// <summary>قانون کم کاري 2-2</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي چهل و دو-42 درنظر گرفته شده است</remarks>
        public virtual void R42(AssignedRule MyRule)
        {
            //کارکردخالص ساعتي ماهانه 8

            //مدت تعجيل مجازماهانه 3013

            //تعجيل ساعتي مجاز ماهانه 3025
            //تعجيل ساعتي غيرمجاز ماهانه 3033

            //غیبت ساعتی مجاز ماهانه 3026 
            //3034 غیبت ساعتی غیرمجاز ماهانه

            if (/*this.DoConcept(3013).Value <=*/
               MyRule["First", this.RuleCalculateDate].ToInt() <=
               this.DoConcept(3025).Value)
            {
                GetLog(MyRule, " Before Execute State:", 8, 3025, 3026, 3033, 3034);

                int tmp = this.DoConcept(3025).Value - MyRule["First", this.RuleCalculateDate].ToInt();
                this.DoConcept(8).Value -= tmp;
                this.DoConcept(3026).Value -= tmp;
                this.DoConcept(3025).Value -= tmp;

                this.DoConcept(3034).Value += tmp;
                this.DoConcept(3033).Value += tmp;

                GetLog(MyRule, " After Execute State:", 8, 3025, 3026, 3033, 3034);
            }
        }

        /// <summary>قانون کم کاري 2-3</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي چهل و سه-43 درنظر گرفته شده است</remarks>
        public virtual void R43(AssignedRule MyRule)
        {
            //کارکردخالص ساعتي ماهانه 8

            //مدت غيبت بين وقت مجازماهانه 3018

            //غيبت بين وقت ساعتي مجاز ماهانه 3027
            //3035 غيبت بين وقت ساعتي غيرمجاز ماهانه

            //غیبت ساعتی مجاز ماهانه 3026 
            //3034 غیبت ساعتی غیرمجاز ماهانه

            if (this.DoConcept(3018).Value <=
                  this.DoConcept(3027).Value)
            {
                GetLog(MyRule, " Before Execute State:", 8, 3026, 3027, 3034, 3035);
                int tmp = this.DoConcept(3027).Value - this.DoConcept(3018).Value;
                this.DoConcept(8).Value -= tmp;
                this.DoConcept(3026).Value -= tmp;
                this.DoConcept(3027).Value -= tmp;

                this.DoConcept(3034).Value += tmp;
                this.DoConcept(3035).Value += tmp;

                GetLog(MyRule, " After Execute State:", 8, 3026, 3027, 3034, 3035);
            }
        }

        /// <summary>قانون کم کاري 3-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي چهل و چهار-44 درنظر گرفته شده است</remarks>
        public virtual void R44(AssignedRule MyRule)
        {
            //3001 غيبت خالص ساعتي
            //کارکردخالص ساعتي 2

            //غيبت ساعتي مجاز 3020
            //3028 غيبت ساعتي غيرمجاز

            //1002 مرخصي خالص استحقاقي ساعتي 
            //1056 مرخصی بی حقوق ساعتی 12
            //2002 ماموريت خالص ساعتي

            GetLog(MyRule, " Before Execute State:", 2, 3020, 3028, 1002, 2002);
            this.DoConcept(1002);
            this.DoConcept(1056);
            this.DoConcept(2002);
            if (this.DoConcept(3020).Value >= MyRule["First", this.RuleCalculateDate].ToInt())
            {
                int tmp = this.DoConcept(3020).Value - MyRule["First", this.RuleCalculateDate].ToInt();
                this.DoConcept(2).Value -= tmp;
                //this.DoConcept(3028).Value = this.DoConcept(3001).Value - this.DoConcept(3020).Value;
                this.DoConcept(3028).Value += tmp;
                this.DoConcept(3020).Value = MyRule["First", this.RuleCalculateDate].ToInt();
                if (this.DoConcept(2).Value < 0)
                {
                    this.DoConcept(2).Value = 0;
                }
            }
            GetLog(MyRule, " After Execute State:", 2, 3020, 3028, 1002, 2002);
        }

        /// <summary>قانون کم کاري 3-2</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي چهل و پنج-45 درنظر گرفته شده است</remarks>
        public virtual void R45(AssignedRule MyRule)
        {
            //کل تاخیر یا تعجیل بیش از حد مجاز ماهانه غیبت حساب شود 3006
            //کارکردخالص ساعتي ماهانه 8

            //غيبت ساعتي مجاز ماهانه 3026
            //غيبت ساعتي غيرمجاز ماهانه 3034
            GetLog(MyRule, " Before Execute State:", 8, 3026, 3034);
            if (this.DoConcept(3026).Value > MyRule["First", this.RuleCalculateDate].ToInt() * HourMin)
            {
                if (this.DoConcept(3006).Value == 1)
                {
                    this.DoConcept(3034).Value += this.DoConcept(3026).Value;
                    this.DoConcept(8).Value -= this.DoConcept(3026).Value;
                    this.DoConcept(3026).Value = 0;
                }
                else
                {
                    this.DoConcept(3034).Value += this.DoConcept(3026).Value - MyRule["First", this.RuleCalculateDate].ToInt() * HourMin;
                    this.DoConcept(8).Value -= this.DoConcept(3026).Value + MyRule["First", this.RuleCalculateDate].ToInt() * HourMin;
                    this.DoConcept(3026).Value = MyRule["First", this.RuleCalculateDate].ToInt() * HourMin;
                }
            }
            GetLog(MyRule, " After Execute State:", 8, 3026, 3034);
        }

        /// <summary>قانون کم کاري 4-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي چهل و شش-46 درنظر گرفته شده است</remarks>
        public virtual void R46(AssignedRule MyRule)
        {
            //غيبت ساعتي مجاز ماهانه 3026
            //غيبت ساعتي غيرمجاز ماهانه 3034
            //اضافه کارساعتي مجاز ماهانه 4005
            //3 کارکردناخالص ماهانه            


            GetLog(MyRule, " Before Execute State:", 3026, 4005, 3);

            int tmp = Operation.Minimum(this.DoConcept(3026).Value,
                                            MyRule["First", this.RuleCalculateDate].ToInt());
            this.DoConcept(3026).Value -= tmp;
            this.DoConcept(4005).Value -= tmp;
            this.DoConcept(3).Value -= tmp;

            GetLog(MyRule, " After Execute State:", 3026, 4005, 3);
        }

        /// <summary>قانون کم کاري 5-2</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي چهل و هفت-47 درنظر گرفته شده است</remarks>
        public virtual void R47(AssignedRule MyRule)
        {
            //2 کارکردخالص ساعتي
            //غيبت ساعتي مجاز 3020
            //3028 غيبت ساعتي غيرمجاز

            //1002 مرخصي خالص استحقاقي ساعتي 
            //1056 مرخصی بی حقوق ساعتی 12
            //2002 ماموريت خالص ساعتي

            GetLog(MyRule, " Before Execute State:", 2, 3020, 3028, 1002, 2002);

            this.DoConcept(1002);
            this.DoConcept(1056);
            this.DoConcept(2002);

            if (this.DoConcept(3028).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                //float coEfficient = (MyRule["Second", this.RuleCalculateDate].ToInt() / 100f) + 1;

                //int tmp = this.DoConcept(3028).Value;
                //int tmp2 = (int)Math.Round((tmp * coEfficient));

                //this.DoConcept(2).Value -= tmp2 - tmp;
                //this.DoConcept(3028).Value = tmp2;

                //طبق سند آقای نجاری
                float coEfficient = (MyRule["Second", this.RuleCalculateDate].ToInt() / 100f);
                int tmp = (int)Math.Round((this.DoConcept(3028).Value - MyRule["First", this.RuleCalculateDate].ToInt()) * coEfficient);

                this.DoConcept(3028).Value += tmp;
                this.DoConcept(2).Value -= tmp;
                this.ReCalculate(13);

                if (this.DoConcept(2).Value < 0)
                {
                    this.DoConcept(2).Value = 0;
                }
            }
            GetLog(MyRule, " After Execute State:", 2, 3020, 3028, 1002, 2002);
        }

        /// <summary>قانون کم کاري 6-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي چهل و هشت-48 درنظر گرفته شده است</remarks>
        public virtual void R48(AssignedRule MyRule)
        {
            //غيبت ساعتي مجاز 3020
            //3028 غيبت ساعتي غيرمجاز
            //3004 غيبت روزانه

            //کارکردخالص ساعتي 2
            //4 کارکردخالص روزانه
            //13 کارکردناخالص ساعتی
            //اضافه کار ساعتي 4002

            //1003 مرخصي استحقاقي ساعتي 
            //1056 مرخصی بی حقوق ساعتی 12
            //2002 ماموريت خالص ساعتي


            GetLog(MyRule, " Before Execute State:", 2, 4, 3020, 3028, 4002, 3004, 1002, 2002);

            this.DoConcept(1002);
            this.DoConcept(1056);
            this.DoConcept(2002);
            if (this.DoConcept(3028).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                this.DoConcept(3004).Value = 1;
                this.DoConcept(3020).Value = 0;
                //this.DoConcept(3028).Value = 0;
                ((PairableScndCnpValue)this.DoConcept(3028)).ClearPairs();

                ((PairableScndCnpValue)this.DoConcept(4002)).AppendPairs(((PairableScndCnpValue)this.DoConcept(2)).Pairs);
                this.DoConcept(4).Value = 0;
                this.DoConcept(2).Value = 0;
                this.DoConcept(13).Value = 0;
            }
            GetLog(MyRule, " After Execute State:", 2, 4, 3020, 3028, 4002, 3004, 1002, 2002);
        }

        /// <summary>قانون کم کاري 7-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي چهل و نه-49 درنظر گرفته شده است</remarks>
        public virtual void R49(AssignedRule MyRule)
        {
            //تعجيل ساعتي مجاز 3022
            //تعجيل ساعتي غيرمجاز 3030

            //غيبت ساعتي مجاز 3020
            //3028 غيبت ساعتي غيرمجاز
            //3004 غيبت روزانه

            //کارکردخالص ساعتي 2
            //4 کارکردخالص روزانه
            //13 کارکردناخالص ساعتی


            //1002 مرخصي خالص استحقاقي ساعتي 
            //1056 مرخصی بی حقوق ساعتی 12
            //2002 ماموريت خالص ساعتي

            GetLog(MyRule, " Before Execute State:", 3004, 3020, 3028, 3022, 3030, 4, 2, 13, 1002, 2002);
            this.DoConcept(1002);
            this.DoConcept(1056);
            this.DoConcept(2002);
            if (this.DoConcept(3030).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                this.DoConcept(3004).Value = 1;
                this.DoConcept(3020).Value = 0;
                this.DoConcept(3028).Value = 0;

                this.DoConcept(3022).Value = 0;
                this.DoConcept(3030).Value = 0;

                ///طبق سند الگوریتم لازم نیست کارکرد به اضافه کار اضافه شود
                //((PairableScndCnpValue)this.DoConcept(4002)).AppendPairs(((PairableScndCnpValue)this.DoConcept(2)).Pairs);

                this.DoConcept(4).Value = 0;
                this.DoConcept(2).Value = 0;
                this.DoConcept(13).Value = 0;
            }
            GetLog(MyRule, " After Execute State:", 3004, 3020, 3028, 3022, 3030, 4, 2, 13, 1002, 2002);
        }

        /// <summary>قانون کم کاري 8-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي پنجاه-50 درنظر گرفته شده است</remarks>
        public virtual void R50(AssignedRule MyRule)
        {
            //1066 مرخصی بی حقوق روزانه
            //3028 غيبت ساعتي غيرمجاز
            //کارکردخالص ساعتي 2
            //13 کارکردناخالص ساعتی
            GetLog(MyRule, " Before Execute State:", 2, 3028);
            int tmp = this.DoConcept(1066).Value * MyRule["First", this.RuleCalculateDate].ToInt();
            this.DoConcept(3028).Value += tmp;
            this.DoConcept(2).Value += tmp;
            this.ReCalculate(13);
            GetLog(MyRule, " After Execute State:", 2, 3028);
        }

        /// <summary>قانون کم کاري 9-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي پنجاه و يک-51 درنظر گرفته شده است</remarks>
        public virtual void R51(AssignedRule MyRule)
        {
            throw new NotImplementedException();
        }

        /// <summary>قانون کم کاري 9-2</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي پنجاه و دو-52 درنظر گرفته شده است</remarks>
        public virtual void R52(AssignedRule MyRule)
        {
            //غيبت ساعتي غيرمجاز ماهانه 3034
            //کارکردخالص ساعتي ماهانه 8   
            //کارکرد ناخالص ساعتي ماهانه 3

            GetLog(MyRule, " Before Execute State:", 3034, 8, 3);
            if (this.DoConcept(3034).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                if (MyRule["Second", this.RuleCalculateDate].ToInt() == 0)
                {
                    this.DoConcept(3034).Value -= MyRule["First", this.RuleCalculateDate].ToInt();
                    this.DoConcept(8).Value += MyRule["First", this.RuleCalculateDate].ToInt();
                    this.DoConcept(3).Value += MyRule["First", this.RuleCalculateDate].ToInt();
                }
            }
            else
            {
                int tmp = this.DoConcept(3034).Value;
                this.DoConcept(8).Value += tmp;
                this.DoConcept(3).Value += tmp;
                this.DoConcept(3034).Value = 0;
            }
            GetLog(MyRule, " Before Execute State:", 3034, 8, 3);


            //if (this.DoConcept(3034).Value <= MyRule["First", this.RuleCalculateDate].ToInt())
            //{
            //    GetLog(MyRule, " Before Execute State:", 3, 8, 3034);
            //    //به نظر آقای نجاری لازم نیست با بخشش غیبت غیرمجاز به غیبت مجاز اضافه شود
            //    //this.DoConcept(3026).Value += MyRule["First", this.RuleCalculateDate].ToInt();
            //    int tmp = Operation.Minimum(this.DoConcept(3034).Value, MyRule["First", this.RuleCalculateDate].ToInt());
            //    this.DoConcept(8).Value += tmp;
            //    this.DoConcept(3).Value += tmp;
            //    this.DoConcept(3034).Value -= tmp;

            //    GetLog(MyRule, " After Execute State:", 3, 8, 3034);
            //}
        }

        /// <summary>قانون کم کاري 10-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي پنجاه و سه-53 درنظر گرفته شده است</remarks>
        public virtual void R53(AssignedRule MyRule)
        {
            //در قانون 10-2 لحاظ شده
            throw new NotImplementedException();
        }

        /// <summary>قانون کم کاري 10-2</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي پنجاه و پنج-55 درنظر گرفته شده است</remarks>
        public virtual void R55(AssignedRule MyRule)
        {
            //4002 اضافه کارساعتي
            //2 کارکردخالص ساعتي
            //کارکردلازم 6
            //غيبت ساعتي مجاز 3020
            //3028 غيبت ساعتي غيرمجاز
            //3001 غيبت خالص ساعتي
            //5007 مفهوم جانباز

            GetLog(MyRule, " Before Execute State:", 2, 4002, 3020, 3028, 5007);
            this.DoConcept(2).Value += MyRule["First", this.RuleCalculateDate].ToInt();
            if (this.DoConcept(2).Value > this.Person.GetShiftByDate(this.RuleCalculateDate).Value)
            {
                int tmp = this.DoConcept(2).Value -
                            this.Person.GetShiftByDate(this.RuleCalculateDate).Value;
                if (MyRule["Second", this.RuleCalculateDate].ToInt() == 0)
                {
                    ((PairableScndCnpValue)this.DoConcept(4002)).IncreaseValue(tmp);
                }
                else
                {
                    this.Person.AddRemainLeave(this.RuleCalculateDate, tmp);
                }
                this.DoConcept(2).Value -= tmp;
                this.DoConcept(5007).Value += tmp;
            }
            else
            {
                this.DoConcept(3020).Value -= Operation.Minimum(this.DoConcept(3028).Value, MyRule["First", this.RuleCalculateDate].ToInt());
                this.DoConcept(3028).Value += Operation.Minimum(this.DoConcept(3028).Value, MyRule["First", this.RuleCalculateDate].ToInt());
            }
            GetLog(MyRule, " After Execute State:", 2, 4002, 3020, 3028, 5007);
        }

        /// <summary>قانون کم کاري 12-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي پنجاه و شش-56 درنظر گرفته شده است</remarks>
        public virtual void R56(AssignedRule MyRule)
        {
            //کارکردخالص ساعتي 2
            //غيبت ساعتی غیرمجاز 3028
            //3020 غيبت ساعتی مجاز

            //تعداد بازه های تاخیر 3038

            //مدت تاخيرمجاز 44

            //تاخير ساعتي مجاز 3021
            //3029 تاخير ساعتي غيرمجاز

            //3002 کل تاخیر یا تعجیل بیش از حد مجاز روزانه غیبت حساب شود

            this.DoConcept(3002).Value = 1;


            #region comment
            /*
            GetLog(MyRule, " Before Execute State:", 44, 3020, 3021, 2, 3029, 3022, 3030, 3023, 3031, 3028);
             * 
            if (this.DoConcept(1).Value > 0)
            {
                if (this.DoConcept(44).Value != 0 &&
                    this.DoConcept(3029).Value + this.DoConcept(3021).Value > this.DoConcept(44).Value)
                {
                    this.DoConcept(2).Value -= this.DoConcept(3021).Value;
                    this.DoConcept(3038).Value = 1;
                    //1002 ,2002 از خط پایین حذف شد
                    //زیرا مقدار قبلی آن قابل محاسبه نبود
                    this.ReCalculate(3021, 3029, 3020, 3028);
                }

                //تعجيل خالص ساعتي 3010

                //مدت تعجيل مجاز 3012

                //تعجيل ساعتي مجاز 3022
                //تعجيل ساعتي غيرمجاز 3030

                if (this.DoConcept(3012).Value != 0 &&
                    this.DoConcept(3030).Value + this.DoConcept(3022).Value > this.DoConcept(3012).Value)
                {
                    this.DoConcept(2).Value -= this.DoConcept(3022).Value;
                    this.DoConcept(3036).Value = 1;
                    //1002 ,2002 از خط پایین حذف شد
                    //زیرا مقدار قبلی آن قابل محاسبه نبود
                    this.ReCalculate(3022, 3020, 3030, 3028);
                }

                //3014 غيبت بين وقت خالص ساعتي

                //مدت غيبت بين وقت مجاز 3017

                //غيبت بين وقت ساعتي مجاز 3023
                //غيبت بين وقت ساعتي غيرمجاز 3031
                if (this.DoConcept(3017).Value != 0 &&
                    this.DoConcept(3031).Value + this.DoConcept(3023).Value > this.DoConcept(3017).Value)
                {
                    this.DoConcept(2).Value -= this.DoConcept(3023).Value;
                    //1002 ,2002 از خط پایین حذف شد
                    //زیرا مقدار قبلی آن قابل محاسبه نبود
                    this.ReCalculate(3023, 3020, 3031, 3028);
                }

                if (this.DoConcept(2).Value < 0)
                {
                    this.DoConcept(2).Value = 0;
                }
            }
            GetLog(MyRule, " After Execute State:", 44, 3020, 3021, 2, 3029, 3022, 3030, 3023, 3031, 3028);
             * 
           * */

            #endregion
        }

        /// <summary>قانون کم کاري 13-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي پنجاه و هشت-58 درنظر گرفته شده است</remarks>
        public virtual void R58(AssignedRule MyRule)
        {
            //تاخيرخالص ساعتي ماهانه 3009
            //کارکردخالص ساعتي ماهانه 8
            //غيبت ساعتي ماهانه 3006

            //مدت تاخيرمجازماهانه 45

            //تاخير ساعتي مجاز ماهانه 3024
            //3032 تاخير ساعتي غيرمجاز ماهانه

            //3006  کل تاخیر یا تعجیل بیش از حد مجاز ماهانه غیبت حساب شود

            this.DoConcept(3006).Value = 1;


            #region comment
            /*
            GetLog(MyRule, " Before Execute State:", 8, 3024, 3032, 3033, 3027, 3035);
            if (this.DoConcept(45).Value <=
                    this.DoConcept(3024).Value)
            {
                this.DoConcept(8).Value -= this.DoConcept(3024).Value - this.DoConcept(45).Value;
                this.DoConcept(3024).Value = this.DoConcept(45).Value;
                this.DoConcept(3032).Value = this.DoConcept(3009).Value - this.DoConcept(3024).Value;
            }

            //تعجيل خالص ساعتي ماهانه 49
            //کارکردخالص ساعتي ماهانه 8
            //غيبت ساعتي ماهانه 3006

            //مدت تعجيل مجازماهانه 3013

            //تعجيل ساعتي مجاز ماهانه 3025
            //تعجيل ساعتي غيرمجاز ماهانه 3033

            if (this.DoConcept(3013).Value <=
                    this.DoConcept(3025).Value)
            {
                this.DoConcept(8).Value -= this.DoConcept(3013).Value;
                this.DoConcept(3025).Value = this.DoConcept(3013).Value;
                this.DoConcept(3033).Value = this.DoConcept(3010).Value - this.DoConcept(3025).Value;
            }

            //غيبت بين وقت خالص ساعتي ماهانه 3016
            //کارکردخالص ساعتي ماهانه 8
            //غيبت ساعتي ماهانه 3006

            //مدت غيبت بين وقت مجازماهانه 3018

            //غيبت بين وقت ساعتي مجاز ماهانه 3027
            //3035 غيبت بين وقت ساعتي غيرمجاز ماهانه

            if (this.DoConcept(3018).Value <=
                    this.DoConcept(3027).Value)
            {
                this.DoConcept(8).Value -= this.DoConcept(3018).Value;
                this.DoConcept(3027).Value = this.DoConcept(3018).Value;
                this.DoConcept(3035).Value = this.DoConcept(3016).Value - this.DoConcept(3027).Value;
            }
            GetLog(MyRule, " After Execute State:", 8, 3024, 3032, 3033, 3027, 3035);
             * */

            #endregion
        }

        /// <summary>قانون کم کاري 14-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي نود و نه-59 درنظر گرفته شده است</remarks>
        public virtual void R99(AssignedRule MyRule)
        {
            //1002 مرخصي خالص استحقاقي ساعتي 
            //1056 مرخصی بی حقوق ساعتی 12
            //2002 ماموريت خالص ساعتي

            //3015 غيبت ساعتي در استراحت بين وقت

            //3028 غيبت ساعتی غیرمجاز
            //2 کارکردخالص ساعتی


            GetLog(MyRule, " Before Execute State:", 1002, 2002, 2, 3028);

            this.DoConcept(1002);
            this.DoConcept(1056);
            this.DoConcept(2002);
            if (this.DoConcept(3015).Value > 0)
            {
                this.DoConcept(3028).Value += this.DoConcept(3015).Value;
                this.DoConcept(2).Value -= this.DoConcept(3015).Value;
                this.ReCalculate(13);
                if (this.DoConcept(2).Value < 0)
                {
                    this.DoConcept(2).Value = 0;
                }
            }

            GetLog(MyRule, " After Execute State:", 1002, 2002, 2, 3028);
        }

        /// <summary>قانون کم کاري 15-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي پنجاه و نه-59 درنظر گرفته شده است</remarks>
        public virtual void R59(AssignedRule MyRule)
        {
            //غیبت ساعتی غیرمجاز ماهانه 3034

            GetLog(MyRule, " Before Execute State:", 3034);
            this.DoConcept(3034).Value += this.GetConcept(3034, this.RuleCalculateDate.AddMonths(-1)).Value;
            GetLog(MyRule, " After Execute State:", 3034);
        }

        /// <summary>قانون کم کاري 16-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي شصت-60 درنظر گرفته شده است</remarks>
        public virtual void R60(AssignedRule MyRule)
        {
            //3004 غيبت روزانه
            //کارکردخالص ساعتي 2
            //4 کارکردخالص روزانه
            //7 کارکرددرروز

            GetLog(MyRule, " Before Execute State:", 2, 4, 3004);

            this.DoConcept(2).Value -= this.DoConcept(3004).Value * this.DoConcept(7).Value;
            this.DoConcept(4).Value -= this.DoConcept(3004).Value;
            this.DoConcept(3004).Value *= 2;
            if (this.DoConcept(2).Value < 0)
            {
                this.DoConcept(2).Value = 0;
            }

            GetLog(MyRule, " After Execute State:", 2, 4, 3004);
        }

        /// <summary>قانون کم کاري 17-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي شصت و يک-61 درنظر گرفته شده است</remarks>
        public virtual void R61(AssignedRule MyRule)
        {
            //8 کارکردخالص ساعتي ماهانه
            //3 کارکردناخالص ماهانه

            //تاخيرساعتي ماهانه 3009
            //غيبت ساعتي ماهانه 3006
            //3039 تعداد تاخير غيرمجاز ماهانه
            //جريمه تاخير 3037  

            int tmp = this.DoConcept(3039).Value;
            if (tmp > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                GetLog(MyRule, " Before Execute State:", 3009, 8, 3034, 3, 3037);

                int tmp2 = (tmp - MyRule["First", this.RuleCalculateDate].ToInt()) * MyRule["Second", this.RuleCalculateDate].ToInt();
                this.DoConcept(8).Value -= tmp2;
                this.DoConcept(3).Value -= tmp2;

                this.DoConcept(3009).Value += tmp2;
                this.DoConcept(3034).Value += tmp2;
                this.DoConcept(3037).Value += tmp2;

                GetLog(MyRule, " After Execute State:", 3009, 8, 3034, 3, 3037);
            }
        }

        /// <summary>قانون کم کاري 18-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي شصت و دو-62 درنظر گرفته شده است</remarks>
        public virtual void R62(AssignedRule MyRule)
        {
            //کارکرد خالص ساعتي 2
            //تعطيل رسمي 1
            //تعطيل غير رسمي 2
            //تعطيل نوروز 4
            //غيبت ساعتي مجاز 3020
            //3028 غيبت ساعتي غيرمجاز
            //13 کارکردناخالص
            //6 کارکرد لازم

            ProceedTraffic proceedTraffic = this.Person.GetProceedTraficByDate(this.RuleCalculateDate);
            if ((proceedTraffic != null && !proceedTraffic.IsFilled) &&
                !proceedTraffic.HasDailyItem &&
                (this.Person.GetShiftByDate(this.RuleCalculateDate).Value > 0) &&
                (!EngEnvironment.HasCalendar(this.RuleCalculateDate, "1", "2", "4")) &&
                this.DoConcept(3028).Value <= MyRule["First", this.RuleCalculateDate].ToInt())
            {
                GetLog(MyRule, " Before Execute State:", 2, 13, 3028);

                //ProceedTrafficPair pair = proceedTraffic.Pairs.Last();
                //if (!pair.IsFilled && (pair.PishcardCode == 0 || pair.PishcardCode == 10))
                //{
                this.DoConcept(3028).Value = MyRule["First", this.RuleCalculateDate].ToInt();
                if (this.DoConcept(2).Value < this.DoConcept(6).Value - this.DoConcept(3028).Value)
                {
                    this.DoConcept(2).Value = this.DoConcept(6).Value - this.DoConcept(3028).Value;
                    this.ReCalculate(13);
                }

                //this.DoConcept(3030).Value = this.DoConcept(3028).Value;
                //}
                GetLog(MyRule, " After Execute State:", 2, 13, 3028);
            }
        }

        /// <summary>قانون کم کاري 19-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي شصت و سه-63 درنظر گرفته شده است</remarks>
        public virtual void R63(AssignedRule MyRule)
        {
            //3028 غيبت ساعتي غيرمجاز

            //کارکردخالص ساعتي 2
            //13 کارکردناخالص ساعتی
            GetLog(MyRule, " Before Execute State:", 2, 3028, 13);

            for (int i = 1; i <= 3; i++)
            {
                int tmp = Operation.Intersect(this.DoConcept(3028),
                                              new PairableScndCnpValuePair(MyRule["Row" + i.ToString() + "_1", this.RuleCalculateDate].ToInt(),
                                                                            MyRule["Row" + i.ToString() + "_2", this.RuleCalculateDate].ToInt())
                                              ).Value * (MyRule["Row" + i.ToString() + "_3", this.RuleCalculateDate].ToInt() / 100);
                this.DoConcept(2).Value -= tmp;
                this.DoConcept(3028).Value += tmp;
            }
            this.ReCalculate(13);
            if (this.DoConcept(2).Value < 0)
            {
                this.DoConcept(2).Value = 0;
            }

            GetLog(MyRule, " After Execute State:", 2, 3028, 13);
        }

        /// <summary>قانون کم کاري 20-1،2،3</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي شصت و چهار-64 درنظر گرفته شده است</remarks>
        public virtual void R64(AssignedRule MyRule)
        {
            //غيبت ساعتي غيرمجاز ماهانه 3034
            //8 کارکردخالص ساعتي ماهانه
            //3 کارکردناخالص ماهانه

            GetLog(MyRule, " Before Execute State:", 8, 3034, 3);

            int tmp = this.DoConcept(3034).Value;
            tmp = tmp * (MyRule["Second", this.RuleCalculateDate].ToInt() / 100);
            if (this.DoConcept(3034).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                tmp = this.DoConcept(3034).Value * (MyRule["Fourth"].ToInt() / 100);
                if (this.DoConcept(3034).Value > MyRule["Third", this.RuleCalculateDate].ToInt())
                {
                    tmp = this.DoConcept(3034).Value * (MyRule["Fifth"].ToInt() / 100);
                }
            }
            this.DoConcept(8).Value -= tmp;
            this.DoConcept(3).Value -= tmp;
            this.DoConcept(3034).Value += tmp;

            GetLog(MyRule, " After Execute State:", 8, 3034, 3);
        }

        /// <summary>قانون کم کاري 21-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي شصت و پنج-65 درنظر گرفته شده است</remarks>
        public virtual void R65(AssignedRule MyRule)
        {
            //کارکردخالص روزانه ماهانه 5
            //3034 غيبت ساعتي غيرمجاز ماهانه

            //3005 غيبت خالص روزانه ماهانه

            //غيبت درروز 3019

            GetLog(MyRule, " Before Execute State:", 3005, 3034, 5);

            int tmp = this.DoConcept(3034).Value / this.DoConcept(3019).Value;
            int tmp2 = this.DoConcept(3034).Value % this.DoConcept(3019).Value;
            this.DoConcept(3005).Value += tmp;
            this.DoConcept(5).Value -= tmp;
            this.DoConcept(3034).Value = tmp2;

            GetLog(MyRule, " After Execute State:", 3005, 3034, 5);
        }

        /// <summary>قانون کم کاري 22-1</summary>
        /// <remarks>شناسه اين قانون در تعاريف بعدي شصت و شش-66 درنظر گرفته شده است</remarks>
        public virtual void R66(AssignedRule MyRule)
        {
            //3004 غيبت روزانه
            //غيبت ساعتي غيرمجازي 3028
            //1 حضور
            //2005 ماموریت روزانه
            //1090 مرخصی روزانه
            //581 مجموع مرخصی بی حقوق روزانه

            //1003 مرخصي خالص استحقاقي ساعتي 
            //1056 مرخصی بی حقوق ساعتی 12
            //2002 ماموريت خالص ساعتي

            GetLog(MyRule, " Before Execute State:", 3028, 3004, 1002, 2002);
            this.DoConcept(1002);
            this.DoConcept(1056);

            this.DoConcept(2002);
            if (this.DoConcept(1).Value == 0 && this.DoConcept(2).Value == 0
                && this.DoConcept(1090).Value == 0 && this.DoConcept(2005).Value == 0
                && this.DoConcept(1091).Value == 0
                && this.Person.GetShiftByDate(this.RuleCalculateDate).Value > 0)
            {
                if (this.DoConcept(3028).Value >= MyRule["First", this.RuleCalculateDate].ToInt() &&
                    this.DoConcept(3028).Value <= MyRule["Second", this.RuleCalculateDate].ToInt())
                {
                    this.DoConcept(3004).Value = 1;
                    this.DoConcept(3028).Value = 0;
                }
                else if (this.Person.GetShiftByDate(this.RuleCalculateDate).Value > MyRule["Second", this.RuleCalculateDate].ToInt() && MyRule["Second", this.RuleCalculateDate].ToInt() != 0)
                {
                    this.DoConcept(3004).Value += this.Person.GetShiftByDate(this.RuleCalculateDate).Value /
                                                MyRule["Second", this.RuleCalculateDate].ToInt();
                    this.DoConcept(3028).Value = this.Person.GetShiftByDate(this.RuleCalculateDate).Value %
                                                MyRule["Second", this.RuleCalculateDate].ToInt();
                }
            }
            GetLog(MyRule, " After Execute State:", 3028, 3004, 1002, 2002);
        }

        /// <summary>
        /// مقادیر تاخیر و تعجیل مختص افراد اعمال شود
        /// </summary>
        /// <param name="MyRule"></param>
        public virtual void R264(AssignedRule MyRule)
        {
            var cnpList = new[] { 2, 13, 3020, 3021, 3022, 3026, 3024, 3025, 3028, 3029, 3030, 3034, 3032, 3033 };

            GetLog(MyRule, " Before Execute State:", cnpList);

            //if (this.RuleCalculateDate.Date == new DateTime(2013,1,22).Date)

            //2 	کارکردخالص ساعتي

            //3020	غيبت ساعتي مجاز
            //3021	تاخير ساعتي مجاز
            //3022	تعجيل ساعتي مجاز
            //3026    غیبت ساعتی مجاز ماهانه

            //3028    غیبت ساعتی غیر مجاز
            //3029	تاخير ساعتي غيرمجاز
            //3034   غيبت ساعتي غيرمجاز ماهانه
            //3030   تعجيل ساعتي غيرمجاز            
            //3032   تاخیر ساعتی غیرمجاز ماهانه 

            //4002   اضافه کارساعتي مجاز

            if (//    تاخیر مجاز فردی
                Utility.ToInteger(this.Person.PersonTASpec.R11) > 0 &&
                Operation.Intersect(this.DoConcept(3029), this.DoConcept(3028)).Value > 0 &&
                this.DoConcept(1).Value > 0)
            {
                if (this.DoConcept(3029).Value > 0)
                {
                    IPair PersonDetailAllowedDelay =
                         new BasePair(
                             this.Person.GetShiftByDate(this.RuleCalculateDate).Pairs.OrderBy(x => x.From).First().From,
                             this.Person.GetShiftByDate(this.RuleCalculateDate).Pairs.OrderBy(x => x.From).First().From + Utility.ToInteger(this.Person.PersonTASpec.R11)
                             );

                    this.DoConcept(3021).Value = PersonDetailAllowedDelay.Value;
                    ((PairableScndCnpValue)this.DoConcept(3029)).AddPairs(Operation.Differance(this.DoConcept(3029), PersonDetailAllowedDelay));

                    this.DoConcept(2).Value += this.DoConcept(3021).Value;

                    if (this.DoConcept(3029).Value > 0)
                        this.DoConcept(3038).Value = 1;

                }
            }

            if (// تعجیل مجاز فردی
                Utility.ToInteger(this.Person.PersonTASpec.R12) > 0 &&
                Operation.Intersect(this.DoConcept(3030), this.DoConcept(3028)).Value > 0 &&
                this.DoConcept(1).Value > 0)
            {

                if (this.DoConcept(3030).Value > 0)
                {
                    this.DoConcept(3022).Value = Operation.Minimum(this.DoConcept(3030).Value, Utility.ToInteger(this.Person.PersonTASpec.R12));
                    ((PairableScndCnpValue)this.DoConcept(3030)).DecreasePairFromLast(this.DoConcept(3022).Value);
                    this.DoConcept(2).Value += this.DoConcept(3022).Value;

                    if (this.DoConcept(3030).Value > 0)
                        this.DoConcept(3038).Value = 1;
                }
            }

            if (Utility.ToInteger(this.Person.PersonTASpec.R11) > 0
                ||
                Utility.ToInteger(this.Person.PersonTASpec.R12) > 0)
            {
                this.ReCalculate(13, 3020, 3028, 3026, 3034);
            }

            GetLog(MyRule, " After Execute State:", cnpList);

        }

        #endregion

        #region قوانين اضافه کاري

        /// <summary>قانون اضافه کاري 1-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف بعدي يکصد و پنجاه-150 درنظر گرفته شده است</remarks>
        public virtual void R150A(AssignedRule MyRule)
        {
            //4015 اضافه کار با مجوز باشد
            this.DoConcept(4015).Value = 1;
        }

        /// <summary>قانون اضافه کاري 1-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف بعدي يکصد و پنجاه-150 درنظر گرفته شده است</remarks>
        public virtual void R150(AssignedRule MyRule)
        {
            //4015 اضافه کار با مجوز باشد
            this.DoConcept(4015).Value = 1;

            ((PairableScndCnpValue)this.DoConcept(4003)).AddPairs(this.DoConcept(4002));
            ((PairableScndCnpValue)this.DoConcept(4002)).ClearPairs();
        }

        /// <summary>قانون اضافه کاري 1-2</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف بعدي يکصد و پنجاه و يک-151 درنظر گرفته شده است</remarks>
        public virtual void R151(AssignedRule MyRule)
        {
            //4016 مفهوم اضافه کار بعد از وقت مجوزی است
            this.DoConcept(4016).Value = 1;
        }

        /// <summary>قانون اضافه کاري 3-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و پنجاه و سه-153 درنظر گرفته شده است</remarks>        
        public virtual void R153(AssignedRule MyRule)
        {
            //اضافه کار خالص ساعتي 56
            //4002 اضافه کار ساعتي مجاز
            //4003 اضافه کار ساعتي غيرمجاز
            //4008 اضافه کارساعتي قبل ازوقت

            GetLog(MyRule, " Before Execute State:", 4002, 4008, 13);
            if (this.DoConcept(4008).Value < MyRule["First", this.RuleCalculateDate].ToInt())
            {
                ((PairableScndCnpValue)this.DoConcept(4002)).DecreasePairFromFirst(this.DoConcept(4008).Value);
                ((PairableScndCnpValue)this.DoConcept(4008)).ClearPairs();
                this.ReCalculate(13);
            }
            GetLog(MyRule, " After Execute State:", 4002, 4008, 13);
        }

        /// <summary>قانون اضافه کاري 3-2</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و پنجاه و چهار-154 درنظر گرفته شده است</remarks>       
        public virtual void R154(AssignedRule MyRule)
        {
            GetLog(MyRule, " Before Execute State:", 4002, 4007, 13);

            //اضافه کار خالص ساعتي 56
            //4002 اضافه کار ساعتي مجاز
            //4003 اضافه کار ساعتي غيرمجاز
            //4007 اضافه کارساعتي بعد ازوقت

            if (this.DoConcept(4007).Value < MyRule["First", this.RuleCalculateDate].ToInt())
            {
                ((PairableScndCnpValue)this.DoConcept(4002)).DecreasePairFromLast(this.DoConcept(4007).Value);
                ((PairableScndCnpValue)this.DoConcept(4007)).ClearPairs();
                this.ReCalculate(13);
            }
            GetLog(MyRule, " After Execute State:", 4002, 4007, 13);
        }

        /// <summary>قانون اضافه کاري 4-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و پنجاه و پنج-10 درنظر گرفته شده است</remarks>       
        public virtual void R155(AssignedRule MyRule)
        {
            GetLog(MyRule, " Before Execute State:", 4002, 4003, 4008, 13);

            //اضافه کار خالص ساعتي 56
            //4002 اضافه کار ساعتي مجاز
            //4003 اضافه کار ساعتي غيرمجاز
            //4008 اضافه کارساعتي قبل ازوقت

            if (this.DoConcept(4008).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                ((PairableScndCnpValue)this.DoConcept(4002)).DecreasePairFromFirst(this.DoConcept(4008).Value - MyRule["First", this.RuleCalculateDate].ToInt());
                ((PairableScndCnpValue)this.DoConcept(4003)).IncreaseValue(this.DoConcept(4008).Value - MyRule["First", this.RuleCalculateDate].ToInt());
                this.DoConcept(4008).Value = MyRule["First", this.RuleCalculateDate].ToInt();
                this.ReCalculate(13);
            }

            GetLog(MyRule, " After Execute State:", 4002, 4003, 4008, 13);
        }

        /// <summary>قانون اضافه کاري 4-2</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و پنجاه و شش-3 درنظر گرفته شده است</remarks>       
        public virtual void R156(AssignedRule MyRule)
        {
            GetLog(MyRule, " Before Execute State:", 4002, 4003, 4007, 13);

            //اضافه کار خالص ساعتي 56
            //4002 اضافه کار ساعتي مجاز
            //4003 اضافه کار ساعتي غيرمجاز
            //4007 اضافه کارساعتي بعد ازوقت

            if (this.DoConcept(4007).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                ((PairableScndCnpValue)this.DoConcept(4002)).DecreasePairFromLast(this.DoConcept(4007).Value - MyRule["First", this.RuleCalculateDate].ToInt());
                ((PairableScndCnpValue)this.DoConcept(4003)).IncreaseValue(this.DoConcept(4007).Value - MyRule["First", this.RuleCalculateDate].ToInt());
                this.DoConcept(4007).Value = MyRule["First", this.RuleCalculateDate].ToInt();
                this.ReCalculate(13);
            }
            GetLog(MyRule, " After Execute State:", 4002, 4003, 4007, 13);
        }

        /// <summary>قانون اضافه کاري 5-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و پنجاه و هفت-1016 درنظر گرفته شده است</remarks>
        public virtual void R157A(AssignedRule MyRule)
        {
            GetLog(MyRule, " Before Execute State:", 4002, 4003, 13);
            //4015 اضافه کار با مجوز باشد
            //اضافه کار خالص ساعتي 56
            //4002 اضافه کار ساعتي مجاز
            //4003 اضافه کار ساعتي غيرمجاز
            //4017 اضافه کار مجاز کارتی

            if (this.DoConcept(4015).Value == 1)
                return;
            if (this.Person.GetShiftByDate(this.RuleCalculateDate).Value > 0
                 && this.DoConcept(4002).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                ((PairableScndCnpValue)this.DoConcept(4003)).IncreaseValue(this.DoConcept(4002).Value - MyRule["First", this.RuleCalculateDate].ToInt());
                ((PairableScndCnpValue)this.DoConcept(4002)).DecreasePairFromLast(this.DoConcept(4002).Value - MyRule["First", this.RuleCalculateDate].ToInt());
                this.ReCalculate(13);
            }
            GetLog(MyRule, " After Execute State:", 4002, 4003, 13);
        }

        /// <summar
        /// 
        /// y>قانون اضافه کاري 5-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و پنجاه و هفت-1016 درنظر گرفته شده است</remarks>
        public virtual void R157(AssignedRule MyRule)
        {
            GetLog(MyRule, " Before Execute State:", 4002, 4003, 13);
            //4015 اضافه کار با مجوز باشد
            //اضافه کار خالص ساعتي 56
            //4002 اضافه کار ساعتي مجاز
            //4003 اضافه کار ساعتي غيرمجاز
            //4017 اضافه کار مجاز کارتی

            if (this.DoConcept(4015).Value == 1)
                return;
            if (this.Person.GetShiftByDate(this.RuleCalculateDate).Value > 0
                 && this.DoConcept(4002).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                int notAllowedValue = this.DoConcept(4002).Value - MyRule["First", this.RuleCalculateDate].ToInt();
                foreach (IPair pair in ((PairableScndCnpValue)this.DoConcept(4002)).Pairs)
                {
                    if (pair.Value - notAllowedValue > 0)
                    {
                        IPair notAllowedPair = new PairableScndCnpValuePair(pair.To - notAllowedValue, pair.To);

                        ((PairableScndCnpValue)this.DoConcept(4003)).AppendPair(notAllowedPair);

                        pair.To -= notAllowedValue;
                        this.DoConcept(4002).Value = ((PairableScndCnpValue)this.DoConcept(4002)).PairValues;

                        break;
                    }
                    else if (pair.Value - notAllowedValue == 0)
                    {
                        ((PairableScndCnpValue)this.DoConcept(4003)).AppendPair(pair);

                        pair.From = pair.To = 0;
                        this.DoConcept(4002).Value = ((PairableScndCnpValue)this.DoConcept(4002)).PairValues;

                        break;
                    }
                    else
                    {
                        ((PairableScndCnpValue)this.DoConcept(4003)).AppendPair(pair);

                        notAllowedValue -= pair.Value;

                        pair.From = pair.To = 0;
                        this.DoConcept(4002).Value = ((PairableScndCnpValue)this.DoConcept(4002)).PairValues;
                    }
                }
                this.ReCalculate(13);
            }
            GetLog(MyRule, " After Execute State:", 4002, 4003, 13);
        }

        /// <summary>قانون اضافه کاري 5-2</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و پنجاه و هشت-158 درنظر گرفته شده است</remarks>
        public virtual void R158A(AssignedRule MyRule)
        {
            GetLog(MyRule, " Before Execute State:", 4002, 4003, 13);

            //4015 اضافه کار با مجوز باشد
            //اضافه کار خالص ساعتي 56
            //4002 اضافه کار ساعتي مجاز
            //4003 اضافه کار ساعتي غيرمجاز

            if (this.DoConcept(4015).Value == 1)
                return;
            if (this.Person.GetShiftByDate(this.RuleCalculateDate).Value == 0
                && this.DoConcept(4002).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                ((PairableScndCnpValue)this.DoConcept(4003)).AssignValue(this.DoConcept(4002).Value - MyRule["First", this.RuleCalculateDate].ToInt());
                ((PairableScndCnpValue)this.DoConcept(4002)).DecreasePairFromLast(this.DoConcept(4002).Value - MyRule["First", this.RuleCalculateDate].ToInt());
                this.ReCalculate(13);
            }
            GetLog(MyRule, " After Execute State:", 4002, 4003, 13);
        }

        /// <summary>قانون اضافه کاري 5-2</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و پنجاه و هشت-158 درنظر گرفته شده است</remarks>
        public virtual void R158(AssignedRule MyRule)
        {
            GetLog(MyRule, " Before Execute State:", 4002, 4003, 13);

            //4015 اضافه کار با مجوز باشد
            //اضافه کار خالص ساعتي 56
            //4002 اضافه کار ساعتي مجاز
            //4003 اضافه کار ساعتي غيرمجاز

            if (this.DoConcept(4015).Value == 1)
                return;
            if (this.Person.GetShiftByDate(this.RuleCalculateDate).Value == 0
                && this.DoConcept(4002).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                int notAllowedValue = this.DoConcept(4002).Value - MyRule["First", this.RuleCalculateDate].ToInt();
                foreach (IPair pair in ((PairableScndCnpValue)this.DoConcept(4002)).Pairs)
                {
                    if (pair.Value - notAllowedValue > 0)
                    {
                        IPair notAllowedPair = new PairableScndCnpValuePair(pair.To - notAllowedValue, pair.To);

                        ((PairableScndCnpValue)this.DoConcept(4003)).AppendPair(notAllowedPair);

                        pair.To -= notAllowedValue;
                        this.DoConcept(4002).Value = ((PairableScndCnpValue)this.DoConcept(4002)).PairValues;

                        break;
                    }
                    else if (pair.Value - notAllowedValue == 0)
                    {
                        ((PairableScndCnpValue)this.DoConcept(4003)).AppendPair(pair);

                        pair.From = pair.To = 0;
                        this.DoConcept(4002).Value = ((PairableScndCnpValue)this.DoConcept(4002)).PairValues;

                        break;
                    }
                    else
                    {
                        ((PairableScndCnpValue)this.DoConcept(4003)).AppendPair(pair);

                        notAllowedValue -= pair.Value;

                        pair.From = pair.To = 0;
                        this.DoConcept(4002).Value = ((PairableScndCnpValue)this.DoConcept(4002)).PairValues;
                    }
                }
                this.ReCalculate(13);
            }
            GetLog(MyRule, " After Execute State:", 4002, 4003, 13);
        }

        /// <summary>قانون اضافه کاري 6-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و پنجاه و نه-1018 درنظر گرفته شده است</remarks>
        public virtual void R159(AssignedRule MyRule)
        {
            GetLog(MyRule, " Before Execute State:", 3, 4005, 4006, 4018);

            //4005 اضافه کارساعتي مجاز ماهانه
            //4006 اضافه کارساعتي غيرمجاز ماهانه
            //3 کارکرد ناخالص ساعتی ماهانه
            //4018 مفهوم حداکثر اضافه کار مجاز ماهانه
            //if (this.DoConcept(4005).Value >= MyRule["First", this.RuleCalculateDate].ToInt() * HourMin)
            this.DoConcept(4018).Value = MyRule["First", this.RuleCalculateDate].ToInt();
            if (this.DoConcept(4005).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                this.DoConcept(3).Value -= this.DoConcept(4005).Value - MyRule["First", this.RuleCalculateDate].ToInt();
                this.DoConcept(4006).Value += this.DoConcept(4005).Value - MyRule["First", this.RuleCalculateDate].ToInt();
                this.DoConcept(4005).Value = MyRule["First", this.RuleCalculateDate].ToInt();

                //if (this.DoConcept(3).Value < 0)
                //{
                //    this.DoConcept(3).Value = 0;
                //}
            }
            GetLog(MyRule, " After Execute State:", 3, 4005, 4006, 4018);
        }

        /// <summary>قانون اضافه کاري 6-2</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و شصت-1019 درنظر گرفته شده است</remarks>
        public virtual void R160(AssignedRule MyRule)
        {
            ///به دليل اينکه در مورد اضافه کار تعطيل نيازي به نگهداري مقادير مجاز
            ///و غير مجاز نيست در اينجا خود اضافه کار تعطيل را مقداردهي مي نماييم
            GetLog(MyRule, " Before Execute State:", 3, 4005, 4006, 4010);

            //4010 مفهوم اضافه کارساعتي تعطيل ماهانه
            //4005 اضافه کارساعتي مجاز ماهانه
            //4006 اضافه کارساعتي غيرمجاز ماهانه
            //3 کارکرد ناخالص ساعتی ماهانه

            if (MyRule["First", this.RuleCalculateDate].ToInt() > 0
                 && this.DoConcept(4010).Value > MyRule["First", this.RuleCalculateDate].ToInt() * HourMin)
            {
                int tmp = this.DoConcept(4010).Value - MyRule["First", this.RuleCalculateDate].ToInt() * HourMin;
                this.DoConcept(3).Value -= tmp;
                this.DoConcept(4005).Value -= tmp;
                this.DoConcept(4006).Value += tmp;
                this.DoConcept(4010).Value = MyRule["First", this.RuleCalculateDate].ToInt() * HourMin;
            }
            GetLog(MyRule, " After Execute State:", 3, 4005, 4006, 4010);
        }

        /// <summary>حد اکثر اضافه کاری روز تعطیل رسمی</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و پنجاه و هشت-158 درنظر گرفته شده است</remarks>
        public virtual void R161(AssignedRule MyRule)
        {
            GetLog(MyRule, " Before Execute State:", 4002, 4003, 13);

            //4015 اضافه کار با مجوز باشد
            //اضافه کار خالص ساعتي 56
            //4002 اضافه کار ساعتي مجاز
            //4003 اضافه کار ساعتي غيرمجاز

            if (this.DoConcept(4015).Value == 1)
                return;
            if (EngEnvironment.HasCalendar(this.RuleCalculateDate, "1")
                && this.DoConcept(4002).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                int notAllowedValue = this.DoConcept(4002).Value - MyRule["First", this.RuleCalculateDate].ToInt();
                foreach (IPair pair in ((PairableScndCnpValue)this.DoConcept(4002)).Pairs)
                {
                    if (pair.Value - notAllowedValue > 0)
                    {
                        IPair notAllowedPair = new PairableScndCnpValuePair(pair.To - notAllowedValue, pair.To);

                        ((PairableScndCnpValue)this.DoConcept(4003)).AppendPair(notAllowedPair);

                        pair.To -= notAllowedValue;
                        this.DoConcept(4002).Value = ((PairableScndCnpValue)this.DoConcept(4002)).PairValues;

                        break;
                    }
                    else if (pair.Value - notAllowedValue == 0)
                    {
                        ((PairableScndCnpValue)this.DoConcept(4003)).AppendPair(pair);

                        pair.From = pair.To = 0;
                        this.DoConcept(4002).Value = ((PairableScndCnpValue)this.DoConcept(4002)).PairValues;

                        break;
                    }
                    else
                    {
                        ((PairableScndCnpValue)this.DoConcept(4003)).AppendPair(pair);

                        notAllowedValue -= pair.Value;

                        pair.From = pair.To = 0;
                        this.DoConcept(4002).Value = ((PairableScndCnpValue)this.DoConcept(4002)).PairValues;
                    }
                }
                this.ReCalculate(13);
            }
            GetLog(MyRule, " After Execute State:", 4002, 4003, 13);
        }

        /// <summary>قانون اضافه کاري 7-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و شصت و دو-162 درنظر گرفته شده است</remarks>
        public virtual void R162(AssignedRule MyRule)
        {
            //1095 مجموع انواع مرخصی روزانه
            //4002 اضافه کار ساعتي مجاز
            //کارکرد خالص ساعتي 2
            //13 کارکرد ناخالص ساعتی

            //3021 اضافه کار اجباري

            GetLog(MyRule, " Before Execute State:", 4002, 2, 13);

            if (this.Person.GetShiftByDate(this.RuleCalculateDate).Value == 0
                && this.DoConcept(1095).Value > 0)
                return;

            int tmp = Operation.Minimum(this.DoConcept(2).Value, MyRule["First", this.RuleCalculateDate].ToInt());
            ((PairableScndCnpValue)this.DoConcept(4002)).IncreaseValue(tmp);
            this.DoConcept(2).Value -= tmp;
            this.ReCalculate(13);

            GetLog(MyRule, " After Execute State:", 4002, 2, 13);

        }

        /// <summary>قانون اضافه کاري 8-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و شصت و سه-163 درنظر گرفته شده است</remarks>
        public virtual void R163(AssignedRule MyRule)
        {
            //4002 اضافه کار ساعتي مجاز
            //13 کارکرد ناخالص
            //4008 اضافه کاراول وقت
            //4007 اضافه کارآخروقت
            float i = 0;

            //روز عادي(روزي که کاري باشد
            this.DoConcept(4026).Value = MyRule["First", this.RuleCalculateDate].ToInt();
            this.DoConcept(4027).Value = MyRule["Second", this.RuleCalculateDate].ToInt();
            this.DoConcept(4028).Value = MyRule["Third", this.RuleCalculateDate].ToInt();
            if (this.Person.GetShiftByDate(this.RuleCalculateDate).Value > 0)
            {
                GetLog(MyRule, " Before Execute State:", 4002, 4007, 4008, 13);

                float coEfficient = MyRule["Second", this.RuleCalculateDate].ToInt() / 100f;
                //coEfficient += 1;
                int min = Operation.Minimum(this.DoConcept(4002).Value, MyRule["First", this.RuleCalculateDate].ToInt());
                i = min * coEfficient;
                if (this.DoConcept(4002).Value > MyRule["First", this.RuleCalculateDate].ToInt())
                {
                    i += (this.DoConcept(4002).Value - MyRule["First", this.RuleCalculateDate].ToInt()) * (MyRule["Third", this.RuleCalculateDate].ToInt() / 100);
                }

                ((PairableScndCnpValue)this.DoConcept(4002)).IncreaseValue((int)Math.Round(i));
                min = Operation.Minimum(this.DoConcept(4007).Value, MyRule["First", this.RuleCalculateDate].ToInt());
                i = min * coEfficient;
                if (this.DoConcept(4007).Value > MyRule["First", this.RuleCalculateDate].ToInt())
                {
                    i += (this.DoConcept(4007).Value - MyRule["First", this.RuleCalculateDate].ToInt()) * (MyRule["Third", this.RuleCalculateDate].ToInt() / 100);
                }
                ((PairableScndCnpValue)this.DoConcept(4007)).IncreaseValue((int)Math.Round(i));

                min = Operation.Minimum(this.DoConcept(4008).Value, MyRule["First", this.RuleCalculateDate].ToInt() - min);
                i = min * coEfficient;
                if (this.DoConcept(4008).Value > MyRule["First", this.RuleCalculateDate].ToInt())
                {
                    i += (this.DoConcept(4008).Value - MyRule["First", this.RuleCalculateDate].ToInt()) * (MyRule["Third", this.RuleCalculateDate].ToInt() / 100);
                }
                ((PairableScndCnpValue)this.DoConcept(4008)).IncreaseValue((int)Math.Round(i));
                this.ReCalculate(13);

                GetLog(MyRule, " After Execute State:", 4002, 4007, 4008, 13);
            }
        }

        /// <summary>قانون اضافه کاري 9-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و شصت و چهار-164 درنظر گرفته شده است</remarks>
        public virtual void R164(AssignedRule MyRule)
        {
            //4002 اضافه کار ساعتي مجاز
            //اضافه کار ساعتي تعطيل 4009

            //1 تعطيل رسمي
            //2 تعطيل غيررسمي
            this.DoConcept(4026).Value = MyRule["First", this.RuleCalculateDate].ToInt();
            this.DoConcept(4027).Value = MyRule["Second", this.RuleCalculateDate].ToInt();
            this.DoConcept(4028).Value = MyRule["Third", this.RuleCalculateDate].ToInt();
            float i = 0;
            if (EngEnvironment.HasCalendar(this.RuleCalculateDate, "2")
                && !EngEnvironment.HasCalendar(this.RuleCalculateDate, "1"))
            {
                GetLog(MyRule, " Before Execute State:", 4002, 4009);
                float coEfficient = MyRule["Second", this.RuleCalculateDate].ToInt() / 100f;
                //coEfficient += 1;
                int min = Operation.Minimum(this.DoConcept(4002).Value, MyRule["First", this.RuleCalculateDate].ToInt());
                i = min * coEfficient; ;
                if (this.DoConcept(4002).Value > MyRule["First", this.RuleCalculateDate].ToInt())
                {
                    i += (this.DoConcept(4002).Value - MyRule["First", this.RuleCalculateDate].ToInt()) * (MyRule["Third", this.RuleCalculateDate].ToInt() / 100);
                }

                ((PairableScndCnpValue)this.DoConcept(4002)).IncreaseValue((int)Math.Round(i));
                this.DoConcept(4009).Value += (int)Math.Round(i);

                GetLog(MyRule, " After Execute State:", 4002, 4009);
            }
        }

        /// <summary>قانون اضافه کاري 10-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و شصت و پنج-165 درنظر گرفته شده است</remarks>
        public virtual void R165(AssignedRule MyRule)
        {
            //4002 اضافه کار ساعتي مجاز

            float i = 0;

            this.DoConcept(4026).Value = MyRule["First", this.RuleCalculateDate].ToInt();
            this.DoConcept(4027).Value = MyRule["Second", this.RuleCalculateDate].ToInt();
            this.DoConcept(4028).Value = MyRule["Third", this.RuleCalculateDate].ToInt();
            //روز غيرکاري
            if (this.Person.GetShiftByDate(this.RuleCalculateDate).Value == 0
                && !EngEnvironment.HasCalendar(this.RuleCalculateDate, "1", "2"))
            {
                GetLog(MyRule, " Before Execute State:", 4002);
                float coEfficient = MyRule["Second", this.RuleCalculateDate].ToInt() / 100f;
                //coEfficient += 1;
                int min = Operation.Minimum(this.DoConcept(4002).Value, MyRule["First", this.RuleCalculateDate].ToInt());
                i = min * coEfficient;
                if (this.DoConcept(4002).Value > MyRule["First", this.RuleCalculateDate].ToInt())
                {
                    coEfficient = MyRule["Third", this.RuleCalculateDate].ToInt() / 100f;
                    // coEfficient += 1;
                    i += (this.DoConcept(4002).Value - MyRule["First", this.RuleCalculateDate].ToInt()) * coEfficient;
                }
                ((PairableScndCnpValue)this.DoConcept(4002)).IncreaseValue((int)Math.Round(i));

                GetLog(MyRule, " After Execute State:", 4002);
            }
        }

        /// <summary>قانون اضافه کاري 11-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و شصت و سه-163 درنظر گرفته شده است</remarks>
        public virtual void R166(AssignedRule MyRule)
        {
            //4002 اضافه کار ساعتي مجاز
            //اضافه کار ساعتي تعطيل 4009

            //1 تعطيل رسمي
            this.DoConcept(4026).Value = MyRule["First", this.RuleCalculateDate].ToInt();
            this.DoConcept(4027).Value = MyRule["Second", this.RuleCalculateDate].ToInt();
            this.DoConcept(4028).Value = MyRule["Third", this.RuleCalculateDate].ToInt();
            float i = 0;
            if (EngEnvironment.HasCalendar(this.RuleCalculateDate, "1"))
            {
                GetLog(MyRule, " Before Execute State:", 4002, 4009);
                float coEfficient = MyRule["Second", this.RuleCalculateDate].ToInt() / 100f;
                //coEfficient += 1;
                int min = Operation.Minimum(this.DoConcept(4002).Value, MyRule["First", this.RuleCalculateDate].ToInt());
                i = min * coEfficient;
                if (this.DoConcept(4002).Value > MyRule["First", this.RuleCalculateDate].ToInt())
                {
                    coEfficient = MyRule["Third", this.RuleCalculateDate].ToInt() / 100f;
                    //coEfficient += 1;
                    i += (this.DoConcept(4002).Value - MyRule["First", this.RuleCalculateDate].ToInt()) * coEfficient;
                }
                ((PairableScndCnpValue)this.DoConcept(4002)).IncreaseValue((int)Math.Round(i));
                this.DoConcept(4009).Value += (int)Math.Round(i);
                GetLog(MyRule, " After Execute State:", 4002, 4009);
            }

        }

        /// <summary>قانون اضافه کاري 12-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و شصت و پنج-165 درنظر گرفته شده است</remarks>
        public virtual void R186(AssignedRule MyRule)
        {
            //4002 اضافه کار ساعتي مجاز
            //4012 اضافه کارساعتي شب
            this.DoConcept(4026).Value = MyRule["First", this.RuleCalculateDate].ToInt();
            this.DoConcept(4027).Value = MyRule["Second", this.RuleCalculateDate].ToInt();
            this.DoConcept(4028).Value = MyRule["Third", this.RuleCalculateDate].ToInt();
            GetLog(MyRule, " Before Execute State:", 4002, 4012);
            int i = Operation.Minimum(this.DoConcept(4012).Value, MyRule["First", this.RuleCalculateDate].ToInt()) * (MyRule["Second", this.RuleCalculateDate].ToInt() / 100);

            if (this.DoConcept(4012).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                i = (this.DoConcept(4012).Value - MyRule["First", this.RuleCalculateDate].ToInt()) * (MyRule["Third", this.RuleCalculateDate].ToInt() / 100);
            }
            ((PairableScndCnpValue)this.DoConcept(4002)).IncreaseValue(i);
            this.DoConcept(4012).Value += i;
            GetLog(MyRule, " After Execute State:", 4002, 4012);
        }

        /// <summary>قانون اضافه کاري 13-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و شصت و شش-166 درنظر گرفته شده است</remarks>
        public virtual void R187(AssignedRule MyRule)
        {
            //اضافه کار ساعتي تعطيل 4009 
            //4012 اضافه کارساعتي شب
            //4002 اضافه کار ساعتي مجاز
            //4011 اضافه کارساعتي شب تعطيل
            this.DoConcept(4026).Value = MyRule["First", this.RuleCalculateDate].ToInt();
            this.DoConcept(4027).Value = MyRule["Second", this.RuleCalculateDate].ToInt();
            this.DoConcept(4028).Value = MyRule["Third", this.RuleCalculateDate].ToInt();
            GetLog(MyRule, " Before Execute State:", 4009, 4011, 4002, 4012);
            int i = Operation.Minimum(this.DoConcept(4011).Value, MyRule["First", this.RuleCalculateDate].ToInt()) * (MyRule["Second", this.RuleCalculateDate].ToInt() / 100);
            if (this.DoConcept(4011).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                i = (this.DoConcept(4011).Value - MyRule["First", this.RuleCalculateDate].ToInt()) * (MyRule["Third", this.RuleCalculateDate].ToInt() / 100);
            }
            this.DoConcept(4009).Value += i;
            this.DoConcept(4011).Value += i;
            ((PairableScndCnpValue)this.DoConcept(4002)).IncreaseValue(i);
            this.DoConcept(4012).Value += i;

            GetLog(MyRule, " After Execute State:", 4009, 4011, 4002, 4012);
        }

        /// <summary>
        /// اعمال سقف اضافه کار بصورت مجزا برای هر شخص
        /// </summary>
        /// <param name="MyRule"></param>
        public virtual void R188(AssignedRule MyRule)
        {
            GetLog(MyRule, " Before Execute State:", 3, 13, 4005, 4006, 4018);

            //4005 اضافه کارساعتي مجاز ماهانه
            //4006 اضافه کارساعتي غيرمجاز ماهانه
            //3 کارکرد ناخالص ساعتی ماهانه
            //4018 مفهوم حداکثر اضافه کار مجاز ماهانه

            if (
                !string.IsNullOrEmpty(this.Person.PersonTASpec.R7)
                && Utility.ToInteger(this.Person.PersonTASpec.R7) > 0
                && this.DoConcept(4005).Value > 0
                )
            {
                this.DoConcept(4018).Value = Utility.ToInteger(this.Person.PersonTASpec.R7) * 60;
                this.ReCalculate(3, 13, 4005, 4006);
                if (this.DoConcept(4005).Value > Utility.ToInteger(this.Person.PersonTASpec.R7) * 60)
                {
                    this.DoConcept(3).Value -= this.DoConcept(4005).Value - Utility.ToInteger(this.Person.PersonTASpec.R7) * 60;
                    this.DoConcept(4006).Value += this.DoConcept(4005).Value - Utility.ToInteger(this.Person.PersonTASpec.R7) * 60;
                    this.DoConcept(4005).Value = Utility.ToInteger(this.Person.PersonTASpec.R7) * 60;
                }
            }

            GetLog(MyRule, " After Execute State:", 3, 13, 4005, 4006, 4018);
        }

        /// <summary>قانون اضافه کاري 14-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و شصت و هفت-167 درنظر گرفته شده است</remarks>
        public virtual void R167(AssignedRule MyRule)
        {
            //ماموريت خالص شبانه روزي 2008
            //4002 اضافه کار ساعتي مجاز

            //تعطيل رسمي 1
            //2 تعطيل غيررسمي

            ///باید برای انواع ماموریت شبانه روزی اجرا شود
            if (this.DoConcept(2008).Value > 0)
            {
                GetLog(MyRule, " Before Execute State:", 4002, 13);
                if (!EngEnvironment.HasCalendar(this.RuleCalculateDate, "1", "2"))
                {
                    ((PairableScndCnpValue)this.DoConcept(4002)).IncreaseValue(MyRule["First", this.RuleCalculateDate].ToInt());
                }
                else
                {
                    ((PairableScndCnpValue)this.DoConcept(4002)).IncreaseValue(MyRule["Second", this.RuleCalculateDate].ToInt());

                }
                this.ReCalculate(13);

                GetLog(MyRule, " After Execute State:", 4002, 13);
            }
        }

        /// <summary>قانون اضافه کاري 15-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و شصت و هشت-4029 درنظر گرفته شده است</remarks>
        public virtual void R168(AssignedRule MyRule)
        {
            //ماموريت روزانه 2005
            //4002 اضافه کار ساعتي مجاز

            //تعطيل رسمي 1
            //2 تعطيل غيررسمي

            if (this.DoConcept(2005).Value > 0)
            {
                GetLog(MyRule, " Before Execute State:", 4002, 13);
                if (EngEnvironment.HasCalendar(this.RuleCalculateDate, "1", "2"))
                {
                    ((PairableScndCnpValue)this.DoConcept(4002)).IncreaseValue(MyRule["Second", this.RuleCalculateDate].ToInt());
                }
                else
                {
                    ((PairableScndCnpValue)this.DoConcept(4002)).IncreaseValue(MyRule["First", this.RuleCalculateDate].ToInt());
                }
                this.ReCalculate(13);
                GetLog(MyRule, " After Execute State:", 4002, 13);
            }
        }

        /// <summary>قانون اضافه کاري 16-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و شصت و نه-169 درنظر گرفته شده است</remarks>
        public virtual void R169(AssignedRule MyRule)
        {
            //4002 اضافه کار ساعتي مجاز

            //تعطيل رسمي 1
            //2 تعطيل غيررسمي

            if (EngEnvironment.HasCalendar(this.RuleCalculateDate, "1", "2")
                && (this.Person.GetShiftByDate(this.RuleCalculateDate).Value > 0))
            {
                GetLog(MyRule, " Before Execute State:", 4002, 13);
                ((PairableScndCnpValue)this.DoConcept(4002)).IncreaseValue(MyRule["First", this.RuleCalculateDate].ToInt());
                this.ReCalculate(13);
                GetLog(MyRule, " After Execute State:", 4002, 13);
            }
        }

        /// <summary>قانون اضافه کاري 17-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و هفتاد-170 درنظر گرفته شده است</remarks>
        public virtual void R170(AssignedRule MyRule)
        {
            //1 مفهوم حضور                         
            //4002 اضافه کار ساعتي مجاز

            if (this.DoConcept(1).Value > 0)
            {
                GetLog(MyRule, " Before Execute State:", 4002, 13);
                ((PairableScndCnpValue)this.DoConcept(4002)).IncreaseValue(MyRule["First", this.RuleCalculateDate].ToInt());
                this.ReCalculate(13);
                GetLog(MyRule, " After Execute State:", 4002, 13);
            }
        }

        /// <summary>قانون اضافه کاري 18-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و هفتاد و يک-171 درنظر گرفته شده است</remarks>
        public virtual void R171(AssignedRule MyRule)
        {
            //اضافه کار ساعتي 4002
            //4014 اضافه کار مجاز بين وقت
            //4012 اضافه کارساعتي مجازشب
            //69 مفهوم استراحت بين وقت
            //14 مفهوم شب

            GetLog(MyRule, " Before Execute State:", 4002, 4014, 4012, 13);

            ((PairableScndCnpValue)this.DoConcept(4002)).AddPairs(Operation.Differance(this.DoConcept(4002), this.DoConcept(4014)));
            ((PairableScndCnpValue)this.DoConcept(4012)).AddPairs(Operation.Differance(this.DoConcept(4012), this.DoConcept(4014)));
            this.DoConcept(13).Value -= this.DoConcept(4014).Value;
            ((PairableScndCnpValue)this.DoConcept(4014)).ClearPairs();

            GetLog(MyRule, " After Execute State:", 4002, 4014, 4012, 13);
        }

        /// <summary>قانون اضافه کاري 19-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و هشتاد و چهار-184 درنظر گرفته شده است</remarks>
        public virtual void R184(AssignedRule MyRule)
        {
            //اضافه کارساعتي مجاز 4002
            //13 کارکرد ناخالص
            //4003 اضافه کارساعتي غيرمجاز


            GetLog(MyRule, " Before Execute State:", 4002, 13, 4003);

            ((PairableScndCnpValue)this.DoConcept(4002)).IncreaseValue(this.DoConcept(4003).Value);
            this.ReCalculate(13);
            ((PairableScndCnpValue)this.DoConcept(4003)).ClearPairs();

            GetLog(MyRule, " After Execute State:", 4002, 13, 4003);
        }

        /// <summary>قانون اضافه کاري 21-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و هشتاد و پنج-185 درنظر گرفته شده است</remarks>
        public virtual void R185(AssignedRule MyRule)
        {
            //4005 اضافه کارساعتي مجاز ماهانه
            //3 کارکردناخالص ماهانه
            //اضافه کارساعتي غيرمجاز ماهانه 4006

            GetLog(MyRule, " Before Execute State:", 4005, 3);

            //this.DoConcept(4006).Value = this.DoConcept(4005).Value;

            this.DoConcept(3).Value -= this.DoConcept(4005).Value;
            this.DoConcept(4005).Value = 0;

            GetLog(MyRule, " After Execute State:", 4005, 3);
        }

        /// <summary>قانون اضافه کاري 22-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و هفتاد و دو-172 درنظر گرفته شده است</remarks>
        public virtual void R172(AssignedRule MyRule)
        {
            //ماموريت روزانه 2005            
            //اضافه کار ساعتي 4002
            //1 مفهوم حضور

            if (this.DoConcept(2005).Value > 0 && this.DoConcept(1).Value > 0)
            {
                GetLog(MyRule, " Before Execute State:", 4002, 13);

                ((PairableScndCnpValue)this.DoConcept(4002)).AddPairs(((PairableScndCnpValue)this.DoConcept(1)).Pairs);

                //float coEfficient = 1 + (MyRule["First", this.RuleCalculateDate].ToInt() / 100f);
                var coEfficient = (int)Math.Round((decimal)(this.DoConcept(4002).Value * (MyRule["First", this.RuleCalculateDate].ToInt() / 100)));

                //((PairableScndCnpValue)this.DoConcept(4002)).IncreaseValue((int)Math.Round(this.DoConcept(4002).Value * coEfficient));
                ((PairableScndCnpValue)this.DoConcept(4002)).IncreaseValue(coEfficient);
                this.ReCalculate(13);

                GetLog(MyRule, " After Execute State:", 4002, 13);
            }
        }

        /// <summary>قانون اضافه کاري 23-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و هفتاد و سه-173 درنظر گرفته شده است</remarks>
        public virtual void R173(AssignedRule MyRule)
        {
            //3028 غیبت ساعتی
            //مجموع انواع مرخصي روزانه 1090            
            //اضافه کار ساعتي 4002
            //2030 کار خارج از اداره
            //2023 مجموع ماموريت ساعتي
            //1 مفهوم حضور
            //4025 تبدیل حضور به اضافه کار در روز مرخصی

            if (this.DoConcept(1090).Value > 0)// && this.DoConcept(4025).Value == 0)
            {
                GetLog(MyRule, " Before Execute State:", 4002, 13);

                ((PairableScndCnpValue)this.DoConcept(4002)).ClearPairs();

                foreach (var pair in ((PairableScndCnpValue)this.DoConcept(1)).Pairs)
                {
                    ((PairableScndCnpValue)this.DoConcept(4002)).AppendPair(pair);

                    var coEfficient = (int)Math.Round((decimal)((pair.Value * MyRule["First", this.RuleCalculateDate].ToInt()) / 100));
                    ((PairableScndCnpValue)this.DoConcept(4002)).IncreaseValue(coEfficient);
                }

                this.ReCalculate(13);

                GetLog(MyRule, " After Execute State:", 4002, 13);
            }
        }

        /// <summary>قانون اضافه کاري 24-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و هفتاد و پنج-175 درنظر گرفته شده است</remarks>
        public virtual void R175(AssignedRule MyRule)
        {
            //اضافه کار ساعتي 4002            
            //1 تعطیل رسمی
            //2 تعطیل غیر رسمی
            //4009 اضافه کارساعتي تعطيل
            //140 کشيک 

            if (EngEnvironment.HasCalendar(this.RuleCalculateDate, "1", "2")
                && this.DoConcept(4009).Value >= MyRule["First", this.RuleCalculateDate].ToInt())
            {
                GetLog(MyRule, " Before Execute State:", 5006, 4009, 4002, 13);

                this.DoConcept(5006).Value = 1;
                this.DoConcept(4009).Value -= MyRule["First", this.RuleCalculateDate].ToInt();
                this.DoConcept(4002).Value -= MyRule["First", this.RuleCalculateDate].ToInt();
                ((PairableScndCnpValue)this.DoConcept(4002)).DecreasePairFromLast(MyRule["First", this.RuleCalculateDate].ToInt());
                this.ReCalculate(13);

                GetLog(MyRule, " After Execute State:", 5006, 4009, 4002, 13);
            }
        }

        /// <summary>قانون اضافه کاري 25-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و هفتاد و شش-176 درنظر گرفته شده است</remarks>
        public virtual void R176(AssignedRule MyRule)
        {
            //3003 مفهوم غيبت روزانه
            //اضافه کار ساعتي 4001            
            //4022 مفهوم تعطيل کاري            


            if ((this.Person.GetShiftByDate(this.RuleCalculateDate).Value == 0)
                && (this.DoConcept(4002).Value) >= MyRule["First", this.RuleCalculateDate].ToInt())
            {
                GetLog(MyRule, " Before Execute State:", 4002, 4022, 13);

                this.DoConcept(4022).Value = 1;
                ((PairableScndCnpValue)this.DoConcept(4002)).DecreasePairFromLast(MyRule["Second", this.RuleCalculateDate].ToInt());
                this.ReCalculate(13);

                GetLog(MyRule, " After Execute State:", 4002, 4022, 13);
            }
        }

        /// <summary>قانون اضافه کاري 26-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و هفتاد و هفت-177 درنظر گرفته شده است</remarks>
        public virtual void R177(AssignedRule MyRule)
        {
            //اضافه کار ساعتي 4002            
            //4008 مفهوم اضافه کارساعتي قبل ازوقت

            if (this.DoConcept(4008).Value >= MyRule["First", this.RuleCalculateDate].ToInt())
            {
                GetLog(MyRule, " Before Execute State:", 4008, 4002, 13);

                int tmp = MyRule["Second", this.RuleCalculateDate].ToInt() - MyRule["First", this.RuleCalculateDate].ToInt();
                this.DoConcept(4008).Value += tmp;
                //از همین روش استفاده شود چون گاها این قانون باعث کم شدن اضافه کار میگردد
                this.DoConcept(4002).Value += tmp;
                this.ReCalculate(13);

                GetLog(MyRule, " After Execute State:", 4008, 4002, 13);
            }
        }

        /// <summary>قانون اضافه کاري 27-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و هفتاد و هشت-178 درنظر گرفته شده است</remarks>
        public virtual void R178(AssignedRule MyRule)
        {
            //اضافه کار ساعتي 4001            
            //4007 مفهوم اضافه کارساعتي بعد ازوقت

            if (this.DoConcept(4007).Value >= MyRule["First", this.RuleCalculateDate].ToInt() && this.DoConcept(4007).Value <= MyRule["Second", this.RuleCalculateDate].ToInt())
            {
                GetLog(MyRule, " Before Execute State:", 4002, 4007, 13);

                int tmp = MyRule["Second", this.RuleCalculateDate].ToInt() - this.DoConcept(4007).Value;
                ((PairableScndCnpValue)this.DoConcept(4007)).IncreaseValue(tmp);
                ((PairableScndCnpValue)this.DoConcept(4002)).IncreaseValue(tmp);
                this.ReCalculate(13);

                GetLog(MyRule, " After Execute State:", 4002, 4007, 13);
            }
        }

        /// <summary>قانون اضافه کاري 28-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و هفتاد و نه-179 درنظر گرفته شده است</remarks>
        public virtual void R179(AssignedRule MyRule)
        {
            //اضافه کار ساعتي 4001            
            //4007 مفهوم اضافه کارساعتي بعد ازوقت

            if (this.DoConcept(4007).Value >= MyRule["First", this.RuleCalculateDate].ToInt() && this.DoConcept(4007).Value <= MyRule["Second", this.RuleCalculateDate].ToInt())
            {
                GetLog(MyRule, " Before Execute State:", 4002, 4007, 13);

                int tmp = MyRule["Second", this.RuleCalculateDate].ToInt() - this.DoConcept(4007).Value;
                ((PairableScndCnpValue)this.DoConcept(4007)).IncreaseValue(tmp);
                ((PairableScndCnpValue)this.DoConcept(4002)).IncreaseValue(tmp);
                this.ReCalculate(13);

                GetLog(MyRule, " After Execute State:", 4002, 4007, 13);
            }
        }

        /// <summary>قانون اضافه کاري 29-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و هشتاد-180 درنظر گرفته شده است</remarks>
        public virtual void R180(AssignedRule MyRule)
        {
            //اضافه کار ساعتي 4001            
            //4007 مفهوم اضافه کارساعتي بعد ازوقت

            if (this.DoConcept(4007).Value >= MyRule["First", this.RuleCalculateDate].ToInt() && this.DoConcept(4007).Value <= MyRule["Second", this.RuleCalculateDate].ToInt())
            {
                GetLog(MyRule, " Before Execute State:", 4002, 4007, 13);

                int tmp = MyRule["Second", this.RuleCalculateDate].ToInt() - this.DoConcept(4007).Value;
                ((PairableScndCnpValue)this.DoConcept(4007)).IncreaseValue(tmp);
                ((PairableScndCnpValue)this.DoConcept(4002)).IncreaseValue(tmp);
                this.ReCalculate(13);

                GetLog(MyRule, " After Execute State:", 4002, 4007, 13);
            }
        }

        /// <summary>قانون اضافه کاري 30-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و هشتاد و يک-181 درنظر گرفته شده است</remarks>
        public virtual void R181(AssignedRule MyRule)
        {
            //اضافه کار ساعتي 4002
            //4003 اضافه کارساعتي غیرمجاز
            //13 کارکردناخالص
            //4023 زمان ناهار

            if (this.DoConcept(4002).Value > 0
                && this.DoConcept(1).Value >= MyRule["First", this.RuleCalculateDate].ToInt()
                && (this.Person.GetShiftByDate(this.RuleCalculateDate).Value == 0)
                && this.DoConcept(2005).Value == 0)
            {
                GetLog(MyRule, " Before Execute State:", 4002, 4003, 13, 4023);

                int tmp = Operation.Minimum(this.DoConcept(4002).Value, MyRule["Second", this.RuleCalculateDate].ToInt());

                ((PairableScndCnpValue)this.DoConcept(4002)).DecreasePairFromLast(tmp);
                ((PairableScndCnpValue)this.DoConcept(4003)).IncreaseValue(tmp);
                this.ReCalculate(13);
                this.DoConcept(4023).Value = tmp;

                GetLog(MyRule, " After Execute State:", 4002, 4003, 13, 4023);
            }
        }

        /// <summary>قانون اضافه کاري 31-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و هشتاد و دو-182 درنظر گرفته شده است</remarks>
        public virtual void R182(AssignedRule MyRule)
        {
            //اضافه کار ساعتي ماهانه 4005
            //4010 مفهوم اضافه کارساعتي تعطيل ماهانه

            int x = this.DoConcept(4005).Value - this.DoConcept(4010).Value;
            if (x > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                GetLog(MyRule, " Before Execute State:", 4010);

                this.DoConcept(4010).Value += x - MyRule["First", this.RuleCalculateDate].ToInt();

                GetLog(MyRule, " After Execute State:", 4010);
            }
        }

        /// <summary>قانون اضافه کاري 32-1</summary>
        /// <param name="Result"></param>
        /// <remarks>شناسه اين قانون در تعاريف يکصد و هشتاد و سه-183 درنظر گرفته شده است</remarks>
        public virtual void R183(AssignedRule MyRule)
        {
            //اضافه کار خاص ساعتي 4001            
            //4002 اضافه کار ساعتی
            //4003 اضافه کار ساعتی عیر مجاز

            if (this.Person.GetShiftByDate(this.RuleCalculateDate).Value == 0)
            {
                GetLog(MyRule, " Before Execute State:", 4002, 4003);

                ((PairableScndCnpValue)this.DoConcept(4003))
                                                .AddPairs(Operation.Differance(this.DoConcept(4002),
                                                            new PairableScndCnpValuePair(MyRule["First", this.RuleCalculateDate].ToInt(), MyRule["Second", this.RuleCalculateDate].ToInt())));
                ((PairableScndCnpValue)this.DoConcept(4002))
                                                .AddPairs(Operation.Intersect(this.DoConcept(4002),
                                                            new PairableScndCnpValuePair(MyRule["First", this.RuleCalculateDate].ToInt(), MyRule["Second", this.RuleCalculateDate].ToInt())));

                GetLog(MyRule, " After Execute State:", 4002, 4003);
            }
        }

        /// <summary>
        /// اضافه کار قبل از ساعات ---- غیر مجاز است
        /// </summary>
        /// <param name="MyRule"></param>
        public virtual void R189(AssignedRule MyRule)
        {
            GetLog(MyRule, " Before Execute State:", 4002, 4003, 4008, 13);

            //4002 اضافه کار ساعتي مجاز
            //4003 اضافه کار ساعتي غيرمجاز
            //4008 اضافه کارساعتي قبل ازوقت
            if (((PairableScndCnpValue)this.DoConcept(4002)).PairCount > 0)
            {
                int fromLimit = MyRule["First", this.RuleCalculateDate].ToInt();
                IList<IPair> pairs = ((PairableScndCnpValue)this.DoConcept(4002)).Pairs.OrderBy(x => x.From).Where(x => x.From < fromLimit).ToList();
                if (pairs != null && pairs.Count > 0)
                {
                    bool applyed = false;
                    foreach (IPair pair in pairs)
                    {
                        if (pair.To <= fromLimit)
                        {
                            PairableScndCnpValue diff = Operation.Differance(this.DoConcept(4002), pair);
                            ((PairableScndCnpValue)this.DoConcept(4002)).AddPairs(diff);
                            ((PairableScndCnpValue)this.DoConcept(4003)).AppendPair(pair);
                            applyed = true;
                        }
                        else if (pair.To > fromLimit)
                        {
                            IPair p = new PairableScndCnpValuePair(pair.From, fromLimit);
                            PairableScndCnpValue diff = Operation.Differance(this.DoConcept(4002), p);
                            ((PairableScndCnpValue)this.DoConcept(4002)).AddPairs(diff);
                            ((PairableScndCnpValue)this.DoConcept(4003)).AppendPair(p);
                            applyed = true;
                        }
                    }
                    if (applyed)
                        this.ReCalculate(4008, 13);
                }
            }
            GetLog(MyRule, " After Execute State:", 4002, 4003, 4008, 13);
        }

        /// <summary>
        /// اضافه کار بعد از ساعات ---- غیر مجاز است
        /// </summary>
        /// <param name="MyRule"></param>
        public virtual void R190(AssignedRule MyRule)
        {
            GetLog(MyRule, " Before Execute State:", 4002, 4003, 4008, 13);

            //4002 اضافه کار ساعتي مجاز
            //4003 اضافه کار ساعتي غيرمجاز
            //4008 اضافه کارساعتي قبل ازوقت
            if (((PairableScndCnpValue)this.DoConcept(4002)).PairCount > 0)
            {
                int toLimit = MyRule["First", this.RuleCalculateDate].ToInt();
                IList<IPair> pairs = ((PairableScndCnpValue)this.DoConcept(4002)).Pairs.OrderBy(x => x.From).Where(x => x.To > toLimit).ToList();
                if (pairs != null && pairs.Count > 0)
                {
                    bool applyed = false;
                    foreach (IPair pair in pairs)
                    {
                        if (pair.From >= toLimit)
                        {
                            PairableScndCnpValue diff = Operation.Differance(this.DoConcept(4002), pair);
                            ((PairableScndCnpValue)this.DoConcept(4002)).AddPairs(diff);
                            ((PairableScndCnpValue)this.DoConcept(4003)).AppendPair(pair);
                            applyed = true;
                        }
                        else if (pair.From < toLimit)
                        {
                            IPair p = new PairableScndCnpValuePair(toLimit, pair.To);
                            PairableScndCnpValue diff = Operation.Differance(this.DoConcept(4002), p);
                            ((PairableScndCnpValue)this.DoConcept(4002)).AddPairs(diff);
                            ((PairableScndCnpValue)this.DoConcept(4003)).AppendPair(p);
                            applyed = true;
                        }
                    }
                    if (applyed)
                        this.ReCalculate(4008, 13);
                }
            }
            GetLog(MyRule, " After Execute State:", 4002, 4003, 4008, 13);
        }

        #endregion

        #region قوانين عمومي

        /// <summary>
        /// وظیفه اجرای مفاهیم ماهانه
        /// </summary>
        /// <param name="MyRule"></param>
        public virtual void R97(AssignedRule MyRule)
        {
            this.DoConcept(9);//حضورماهانه
            this.DoConcept(4005);//اضافه کارساعتي مجاز ماهانه
            this.DoConcept(4006);//اضافه کارساعتي غیرمجاز ماهانه
            this.DoConcept(4020);//اضافه کار بین وقت ماهانه            

            this.DoConcept(3026);//غيبت ساعتي مجاز ماهانه
            this.DoConcept(3034);//غیبت ساعتی غیرمجاز ماهانه
            this.DoConcept(1006);//مرخصي استحقاقي روزانه ماهانه
            this.DoConcept(1011);//مرخصي استحقاقي ساعتي ماهانه
            this.DoConcept(1074);//مرخصي بي حقوق ساعتي ماهانه
            this.DoConcept(1076);//مرخصي بي حقوق روزانه ماهانه
            this.DoConcept(1016);//مرخصی استعلاجی ساعتی ماهانه
            this.DoConcept(3005);//غيبت روزانه ماهانه

            this.DoConcept(8);//کارکردخالص ساعتي ماهانه
            this.DoConcept(5);//کارکردخالص روزانه ماهانه
            this.DoConcept(2007);//ماموريت ساعتي ماهانه
            this.DoConcept(2006);//ماموريت روزانه ماهانه
            this.DoConcept(3);//کارکردناخالص ماهانه
            this.DoConcept(10);//کارکردلازم ماهانه
            this.DoConcept(1017);//مرخصی استعلاجی ماهانه
            this.DoConcept(5013);//کد وضعیت روز جهت رنگ ماهانه
            this.DoConcept(5015);//کارکرد لازم برای حق غذا ماهانه
            this.DoConcept(5016);//طول دوره محدوده محاسبات ماهانه

            this.DoConcept(22);//حضور در تعطیلات خاص ماهانه
            this.DoConcept(1097);// مجموع مرخصی با حقوق روزانه ماهانه

        }

        /// <summary>
        /// وظیفه اجرای مفاهیم روزانه
        /// </summary>
        /// <param name="MyRule"></param>
        public virtual void R98(AssignedRule MyRule)
        {
            this.DoConcept(5008);//نوع
            this.DoConcept(1);//مفهوم حضور
            this.DoConcept(2);//کارکردخالص ساعتي
            this.DoConcept(4);//کارکردخالص روزانه
            this.DoConcept(13);//کارکردناخالص
            this.DoConcept(6);//کارکردلازم
            this.DoConcept(1003);//مرخصي استحقاقي ساعتي
            this.DoConcept(1005);//مرخصي استحقاقي روزانه
            this.DoConcept(1056);//مرخصي بی حقوق ساعتی 12
            this.DoConcept(1066);//مرخصي بی حقوق روزانه 32
            this.DoConcept(2023);//ماموريت ساعتي
            this.DoConcept(2005);//ماموريت روزانه


            this.DoConcept(3004);//غيبت روزانه
            this.DoConcept(1008);//مرخصی استعلاجی ساعتی
            this.DoConcept(2008);//ماموريت خالص شبانه روزي
            this.DoConcept(1010);//مرخصي استعلاجي روزانه

            this.DoConcept(4007);//اضافه کارآخروقت
            this.DoConcept(4017);//اضافه کار مجاز کارتی


            this.DoConcept(5010);//ثبت دستی تردد
            //this.DoConcept(164);//خنثی کردن غیبت توسط مرخصی
            //this.DoConcept(165);//تاخیر سرویس
            this.DoConcept(5009);//نوع روز
            this.DoConcept(5012);//کد وضعیت روز جهت رنگ
            this.DoConcept(5014);//کارکرد لازم برای حق غذا
            this.DoConcept(5017);//حضور منهای اضافه کار در گانت چارت استفاده می گردد

            this.DoConcept(1096);// مجموعه مرخصی با حقوق روزانه

        }

        /// <summary>
        /// اعمال مرخصی استحقاقی در روزها تعطیل بین مرخصی استحقاقی
        /// </summary>
        /// <param name="MyRule"></param>
        public virtual void R200(AssignedRule MyRule)
        {
            //1005 مفهوم مرخصي استحقاقي روزانه
            //114 مفهوم اعمال تعطيلات نوروز در مرخصي 
            //324 تعطیلات رسمی بین مرخصی,مرخصی محسوب شود
            //325 تعطیلات غیر رسمی بین مرخصی,مرخصی محسوب شود
            //326 روزهای غیر کاری بین مرخصی,مرخصی محسوب شود


            GetLog(MyRule, " Before Execute State:", 1003, 1005);
            if (this.DoConcept(1005).Value == 0
                && this.DoConcept(1005, this.RuleCalculateDate.AddDays(-1)).Value > 0)
            {
                bool x1 = Utility.ToBoolean(MyRule["Rasmi", this.RuleCalculateDate].ToInt());
                //bool x1 = this.DoConcept(324).Value > 0 ? true : false;
                bool x2 = EngEnvironment.HasCalendar(this.RuleCalculateDate, "1");

                bool y1 = Utility.ToBoolean(MyRule["GheireRasmi", this.RuleCalculateDate].ToInt());
                //bool y1 = this.DoConcept(325).Value > 0 ? true : false;
                bool y2 = EngEnvironment.HasCalendar(this.RuleCalculateDate, "2");

                bool z1 = Utility.ToBoolean(MyRule["GheireKari", this.RuleCalculateDate].ToInt());
                //bool z1 = this.DoConcept(326).Value > 0 ? true : false;
                bool z2 = (this.Person.GetShiftByDate(this.RuleCalculateDate).Value == 0 ? true : false) & !x2 & !y2;

                int afterDays = 0;
                int maxLoopcounter = 20;
                while ((x1 & x2) | (y1 & y2) | (z1 & z2))
                {
                    afterDays++;
                    maxLoopcounter--;
                    if (maxLoopcounter < 1)
                    {
                        return;
                    }

                    x2 = EngEnvironment.HasCalendar(this.RuleCalculateDate.AddDays(afterDays), "1");

                    y2 = EngEnvironment.HasCalendar(this.RuleCalculateDate.AddDays(afterDays), "2");

                    z2 = this.Person.GetShiftByDate(this.RuleCalculateDate.AddDays(afterDays)).Value == 0 ? true : false & !x2 & !y2;
                }
                if (this.DoConcept(1005, this.RuleCalculateDate.AddDays(afterDays)).Value > 0)
                {
                    for (int i = 0; i < afterDays; i++)
                    {
                        int leaveInDay = this.DoConcept(1001, this.RuleCalculateDate).Value;

                        this.DoConcept(1005, this.RuleCalculateDate.AddDays(i)).Value = 1;
                        this.Person.AddUsedLeave(this.RuleCalculateDate.AddDays(i), leaveInDay, null);
                        this.DoConcept(1003).Value = 0;
                    }
                }
            }

            GetLog(MyRule, " After Execute State:", 1003, 1005);
        }

        /// <summary>
        ///  اعمال مرخصی استعلاجی در روزها تعطیل بین مرخصی استعلاجی
        /// </summary>
        /// <param name="MyRule"></param>
        public virtual void R201(AssignedRule MyRule)
        {
            //1010 مفهوم مرخصي استعلاجی روزانه
            //114 مفهوم اعمال تعطيلات نوروز در مرخصي 
            //327 تعطیلات رسمی بین مرخصی استعلاجی,مرخصی استعلاجی محسوب شود
            //328 تعطیلات غیر رسمی بین مرخصی استعلاجی,مرخصی استعلاجی محسوب شود
            //329 روزهای غیر کاری بین مرخصی استعلاجی,مرخصی استعلاجی محسوب شود

            GetLog(MyRule, " Before Execute State:", 1010);
            if (this.DoConcept(1010).Value == 0
                && this.DoConcept(1010, this.RuleCalculateDate.AddDays(-1)).Value > 0)
            {
                bool x1 = Utility.ToBoolean(MyRule["Rasmi", this.RuleCalculateDate].ToInt());
                //bool x1 = this.DoConcept(327).Value > 0 ? true : false;
                bool x2 = EngEnvironment.HasCalendar(this.RuleCalculateDate, "1");

                bool y1 = Utility.ToBoolean(MyRule["GheireRasmi", this.RuleCalculateDate].ToInt());
                //bool y1 = this.DoConcept(328).Value > 0 ? true : false;
                bool y2 = EngEnvironment.HasCalendar(this.RuleCalculateDate, "2");

                bool z1 = Utility.ToBoolean(MyRule["GheireKari", this.RuleCalculateDate].ToInt());
                //bool z1 = this.DoConcept(329).Value > 0 ? true : false;
                bool z2 = this.Person.GetShiftByDate(this.RuleCalculateDate).Value == 0 ? true : false & !x2 & !y2;

                int afterDays = 0;
                int maxLoopcounter = 20;
                while ((x1 & x2) | (y1 & y2) | (z1 & z2))
                {
                    afterDays++;
                    maxLoopcounter--;
                    if (maxLoopcounter < 1)
                    {
                        return;
                    }

                    x2 = EngEnvironment.HasCalendar(this.RuleCalculateDate.AddDays(afterDays), "1");

                    y2 = EngEnvironment.HasCalendar(this.RuleCalculateDate.AddDays(afterDays), "2");

                    z2 = this.Person.GetShiftByDate(this.RuleCalculateDate.AddDays(afterDays)).Value == 0 ? true : false & !x2 & !y2;
                }
                if (this.DoConcept(1010, this.RuleCalculateDate.AddDays(afterDays)).Value > 0)
                {
                    for (int i = 0; i < afterDays; i++)
                    {
                        this.DoConcept(1010, this.RuleCalculateDate.AddDays(i)).Value = 1;
                    }
                }

            }

            GetLog(MyRule, " After Execute State:", 1010);
        }

        /// <summary>
        /// اعمال مجوز اضافه کار
        /// در اصل اضافه کار را به غیر مجاز تبدیل میکند
        /// </summary>
        /// <param name="MyRule"></param>
        public virtual void R202(AssignedRule MyRule)
        {
            //4002 اضافه کارساعتي مجاز
            //4003 اضافه کارساعتي غیرمجاز       
            //4015 اضافه کار با مجوز باشد
            //4016 مفهوم اضافه کار بعد از وقت مجوزی است
            //4029 مفهوم مجوز اضافه کاری
            //4007 مفهوم اضافه کارآخر وقت            
            //4026 سقف اضافه کار که ضریب تعلق میگیرد

            Permit permit = this.Person.GetPermitByDate(this.ConceptCalculateDate, EngEnvironment.GetPrecard(Precards.OverTime));

            #region Apply Parameters
            int withoutPermitAlow = 0;
            if (this.Person.GetShiftByDate(this.RuleCalculateDate).Value == 0)
                withoutPermitAlow = MyRule["MojazTatil", this.RuleCalculateDate].ToInt();
            else
                withoutPermitAlow = MyRule["MojazAadi", this.RuleCalculateDate].ToInt();
            if (withoutPermitAlow > 0)
            {
                foreach (IPair pair in ((PairableScndCnpValue)this.DoConcept(4003)).Pairs)
                {
                    if (pair.Value - withoutPermitAlow > 0)
                    {
                        IPair allowedPair = new PairableScndCnpValuePair(pair.From, pair.From + withoutPermitAlow);

                        ((PairableScndCnpValue)this.DoConcept(4002)).AppendPair(allowedPair);

                        pair.From += withoutPermitAlow;
                        this.DoConcept(4003).Value = ((PairableScndCnpValue)this.DoConcept(4003)).PairValues;

                        break;
                    }
                    else if (pair.Value - withoutPermitAlow == 0)
                    {
                        ((PairableScndCnpValue)this.DoConcept(4002)).AppendPair(pair);

                        pair.From = pair.To = 0;
                        this.DoConcept(4003).Value = ((PairableScndCnpValue)this.DoConcept(4003)).PairValues;

                        break;
                    }
                    else
                    {
                        ((PairableScndCnpValue)this.DoConcept(4002)).AppendPair(pair);

                        withoutPermitAlow -= pair.Value;

                        pair.From = pair.To = 0;
                        this.DoConcept(4003).Value = ((PairableScndCnpValue)this.DoConcept(4003)).PairValues;
                    }
                }
            }
            #endregion

            if (permit != null && permit.Value > 0)
            {
                if (this.DoConcept(4003).Value > 0)
                {
                    foreach (PermitPair permitPair in permit.Pairs)
                    {
                        //مجوز مقداری و بازه ای - در حال حاضر نمیتوان روی خصیصه جفت بودن در مجوز حساب کرد
                        //لذا از روش زیر جهت شناسایی استفاده میگردد
                        #region Pairly Permit
                        if (permitPair.To - permitPair.From == permitPair.Value)
                        {
                            PairableScndCnpValue allowedOverWork = Operation.Intersect(permitPair, (PairableScndCnpValue)this.DoConcept(4003));
                            PairableScndCnpValue notAllowedOverWork = Operation.Differance(this.DoConcept(4003), allowedOverWork);
                            ((PairableScndCnpValue)this.DoConcept(4002)).AppendPairs(allowedOverWork);
                            ((PairableScndCnpValue)this.DoConcept(4003)).AddPairs(notAllowedOverWork);

                            permitPair.IsApplyedOnTraffic = true;//اعمال شد
                        }
                        #endregion

                        #region Value Permit
                        else if (permitPair.From == 1439 && permitPair.To == 1439 && permitPair.Value > 0)
                        {
                            int permitOverWork = permitPair.Value;

                            foreach (IPair pair in ((PairableScndCnpValue)this.DoConcept(4003)).Pairs)
                            {
                                if (pair.Value - permitOverWork > 0)
                                {
                                    IPair allowedPair = new PairableScndCnpValuePair(pair.From, pair.From + permitOverWork);

                                    ((PairableScndCnpValue)this.DoConcept(4002)).AppendPair(allowedPair);

                                    pair.From += permitOverWork;
                                    this.DoConcept(4003).Value = ((PairableScndCnpValue)this.DoConcept(4003)).PairValues;

                                    break;
                                }
                                else if (pair.Value - permitOverWork == 0)
                                {
                                    ((PairableScndCnpValue)this.DoConcept(4002)).AppendPair(pair);

                                    pair.From = pair.To = 0;
                                    this.DoConcept(4003).Value = ((PairableScndCnpValue)this.DoConcept(4003)).PairValues;

                                    break;
                                }
                                else
                                {
                                    ((PairableScndCnpValue)this.DoConcept(4002)).AppendPair(pair);

                                    permitOverWork -= pair.Value;

                                    pair.From = pair.To = 0;
                                    this.DoConcept(4003).Value = ((PairableScndCnpValue)this.DoConcept(4003)).PairValues;
                                }
                            }
                            permitPair.IsApplyedOnTraffic = true;//اعمال شد
                        }
                        #endregion
                    }
                }
            }

            this.ReCalculate(13);
            GetLog(MyRule, " After Execute State:", 4007, 4002, 4003, 13);
        }

        /// <summary>
        /// اعمال کارکرد در تعطیلات
        /// </summary>
        /// <param name="MyRule"></param>
        public virtual void R203(AssignedRule MyRule)
        {
            //23 مفهوم تعطیلات جزو کارکرد حساب شود
            //24 مفهوم تعطیلات رسمی جزو کارکرد حساب شود 
            //25 مفهوم روزهای غیر کاری جزو کارکرد حساب شود   
            //4 کارکرد خالص روزانه
            //6 مفهوم کارکردلازم
            //3004 غيبت روزانه
            //7 کارکرددرروز    

            bool hourlyWork = true, dailyWork = true;
            if (MyRule.HasParameter("HourlyWork", this.RuleCalculateDate))
            {
                hourlyWork = MyRule["HourlyWork", this.RuleCalculateDate].ToInt() > 0;
            }
            if (MyRule.HasParameter("DailyWork", this.RuleCalculateDate))
            {
                dailyWork = MyRule["DailyWork", this.RuleCalculateDate].ToInt() > 0;
            }

            this.DoConcept(23).Value = MyRule["TatilGheirRasmi", this.RuleCalculateDate].ToInt();
            this.DoConcept(24).Value = MyRule["TatilRasmi", this.RuleCalculateDate].ToInt();
            this.DoConcept(25).Value = MyRule["GheirKari", this.RuleCalculateDate].ToInt();
            bool lastDay = this.CalcDateZone.ToDate.Equals(this.RuleCalculateDate);
            if ((this.DoConcept(6).Value > 0
                && (EngEnvironment.HasCalendar(this.RuleCalculateDate.AddDays(-1), "1", "2")
                || this.Person.GetShiftByDate(this.RuleCalculateDate.AddDays(-1)).Value == 0))
                || lastDay)//روزهای آخر رینج محاسبات
            {

                GetLog(MyRule, " Before Execute State:", 2, 4, 13, 6, 3004);

                bool x1 = this.DoConcept(23).Value > 0 ? true : false;
                bool x2 = EngEnvironment.HasCalendar(this.RuleCalculateDate.AddDays(-1), "2");

                bool y1 = this.DoConcept(24).Value > 0 ? true : false;
                bool y2 = EngEnvironment.HasCalendar(this.RuleCalculateDate.AddDays(-1), "1");

                bool z1 = this.DoConcept(25).Value > 0 ? true : false;
                bool z2 = this.Person.GetShiftByDate(this.RuleCalculateDate.AddDays(-1)).Value == 0 ? true : false;

                int normWork = this.DoConcept(7).Value;
                int beforeDays = 0;
                int bearkCounter = 10;
                while ((x1 & x2) | (y1 & y2) | (z1 & z2))
                {

                    bearkCounter--;
                    if (bearkCounter == 0) { break; }

                    beforeDays++;

                    if (this.Person.EmploymentDate > this.RuleCalculateDate.AddDays(-beforeDays))
                    {
                        break;
                    }

                    x2 = EngEnvironment.HasCalendar(this.RuleCalculateDate.AddDays(-beforeDays), "2");

                    y2 = EngEnvironment.HasCalendar(this.RuleCalculateDate.AddDays(-beforeDays), "1");

                    z2 = this.Person.GetShiftByDate(this.RuleCalculateDate.AddDays(-beforeDays)).Value == 0 ? true : false;
                }
                if (x1 || y1 || z1)
                {
                    bool work = false, absent = false;
                    if (this.CalcDateZone.IsContain(this.RuleCalculateDate.AddDays(-beforeDays)))
                    {
                        //روز قبل یا روز بعد تعطیلات
                        work = this.DoConcept(4, this.RuleCalculateDate.AddDays(-beforeDays)).Value > 0
                            ||
                            this.DoConcept(4).Value > 0;

                        absent = this.DoConcept(3004, this.RuleCalculateDate.AddDays(-beforeDays)).Value > 0
                            &&
                            this.DoConcept(3004).Value > 0;
                    }
                    else   //تعطیلات ابتدای رینج محاسبات
                    {
                        work = true;
                    }
                    if (lastDay)
                    {
                        work = true; absent = false;
                        beforeDays++;
                    }
                    for (int i = lastDay ? 0 : 1; i < beforeDays && this.RuleCalculateDate.AddDays(-i) >= this.MinAssgnRuleDate; i++)
                    {
                        //تعطیل شیفت دار نباید حساب شود
                        if (this.Person.GetShiftByDate(this.RuleCalculateDate.AddDays(-i)).Value > 0
                            && !EngEnvironment.HasCalendar(this.RuleCalculateDate.AddDays(-i), "1", "2"))
                            continue;
                        //اگر شنبه محاسبه شود باید کارکرد جمعه داده شود
                        //if (!this.CalcDateZone.IsContain(this.RuleCalculateDate.AddDays(-i)))
                        //    continue;

                        if (work)
                        {
                            if (hourlyWork)
                                this.DoConcept(2, this.RuleCalculateDate.AddDays(-i)).Value = normWork;
                            if (dailyWork)
                                this.DoConcept(4, this.RuleCalculateDate.AddDays(-i)).Value = 1;
                        }
                        else if (absent)
                        {
                            if (hourlyWork)
                                this.DoConcept(2, this.RuleCalculateDate.AddDays(-i)).Value = 0;
                            if (dailyWork)
                                this.DoConcept(4, this.RuleCalculateDate.AddDays(-i)).Value = 0;
                            //this.DoConcept(3004, this.RuleCalculateDate.AddDays(-i)).Value = 1;
                        }
                        else//این روز احتمالا بدلیل نداشتن قانون محاسبه نشده است
                        {
                            if (hourlyWork)
                                this.DoConcept(2, this.RuleCalculateDate.AddDays(-i)).Value = normWork;
                            if (dailyWork)
                                this.DoConcept(4, this.RuleCalculateDate.AddDays(-i)).Value = 1;
                            //throw new Exception("حالت پیشبینی نشده در قانون 203");
                        }
                        //اگر شخص حضور و اضافه کار داشت نباید اعمال گردد
                        if (this.DoConcept(13, this.RuleCalculateDate.AddDays(-i)).Value == 0)
                        {
                            this.ReCalculate(13, this.RuleCalculateDate.AddDays(-i));
                        }
                        //this.DoConcept(6, this.RuleCalculateDate.AddDays(-i)).Value = normWork;
                        if (this.Person.GetShiftByDate(this.RuleCalculateDate.AddDays(-i)).Value > 0)
                            this.DoConcept(6, this.RuleCalculateDate.AddDays(-i)).Value
                                = this.Person.GetShiftByDate(this.RuleCalculateDate.AddDays(-i)).Value;
                    }
                    //محاسبه دوباره کارکرد ماهانه
                    for (int i = beforeDays - 1; i >= 0 && this.RuleCalculateDate.AddDays(-i) >= this.MinAssgnRuleDate; i--)
                    {

                        //کامنت شد زیرا مثلا شنبه آخر ماه باید دوباره کارکرد ماهانه را حساب کند
                        //if (this.Person.GetShiftByDate(this.RuleCalculateDate.AddDays(-i)).Value > 0)
                        //    continue;
                        if (!this.CalcDateZone.IsContain(this.RuleCalculateDate.AddDays(-i)))
                            continue;
                        this.ReCalculate(5, this.RuleCalculateDate.AddDays(-i));
                    }
                }

                GetLog(MyRule, " After Execute State:", 2, 4, 13, 6, 3004);
            }
        }

        /// <summary>
        /// اعمال ماموریت روزانه در روزها تعطیل بین ماموریت روزانه
        /// </summary>
        /// <param name="MyRule"></param>
        public virtual void R204(AssignedRule MyRule)
        {
            //2005 مفهوم مجموع ماموریت روزانه
            //2047 تعطیلات رسمی بین مرخصی,مرخصی محسوب شود
            //2048 تعطیلات غیر رسمی بین مرخصی,مرخصی محسوب شود
            //2049 روزهای غیر کاری بین مرخصی,مرخصی محسوب شود
            //23 مفهوم تعطیلات جزو کارکرد حساب شود
            //24 مفهوم تعطیلات رسمی جزو کارکرد حساب شود 
            //25 مفهوم روزهای غیر کاری جزو کارکرد حساب شود

            GetLog(MyRule, " Before Execute State:", 2, 4, 2005, 2031, 2032, 2033, 2034, 2035);
            if (this.DoConcept(2005).Value == 0
                && this.DoConcept(2005, this.RuleCalculateDate.AddDays(-1)).Value > 0)
            {
                bool x1 = Utility.ToBoolean(MyRule["Rasmi", this.RuleCalculateDate].ToInt());
                //bool x1 = this.DoConcept(2047).Value > 0 ? true : false;
                bool x2 = EngEnvironment.HasCalendar(this.RuleCalculateDate, "1");

                bool y1 = Utility.ToBoolean(MyRule["GheireRasmi", this.RuleCalculateDate].ToInt());
                //bool y1 = this.DoConcept(2048).Value > 0 ? true : false;
                bool y2 = EngEnvironment.HasCalendar(this.RuleCalculateDate, "2");

                bool z1 = Utility.ToBoolean(MyRule["GheireKari", this.RuleCalculateDate].ToInt());
                //bool z1 = this.DoConcept(2049).Value > 0 ? true : false;
                bool z2 = this.Person.GetShiftByDate(this.RuleCalculateDate).Value == 0 ? true : false;

                int afterDays = 0;
                int maxLoopcounter = 20;
                while ((x1 & x2) | (y1 & y2) | (z1 & z2))
                {
                    afterDays++;
                    maxLoopcounter--;
                    if (maxLoopcounter < 1)
                    {
                        return;
                    }

                    x2 = EngEnvironment.HasCalendar(this.RuleCalculateDate.AddDays(afterDays), "1");

                    y2 = EngEnvironment.HasCalendar(this.RuleCalculateDate.AddDays(afterDays), "2");

                    z2 = this.Person.GetShiftByDate(this.RuleCalculateDate.AddDays(afterDays)).Value == 0 ? true : false;
                }
                if (this.DoConcept(2005, this.RuleCalculateDate.AddDays(afterDays)).Value > 0)
                {
                    for (int i = 0; i < afterDays; i++)
                    {
                        if (this.DoConcept(2031, this.RuleCalculateDate.AddDays(afterDays)).Value > 0)
                        {
                            this.DoConcept(2031, this.RuleCalculateDate.AddDays(i)).Value = 1;
                        }
                        if (this.DoConcept(2032, this.RuleCalculateDate.AddDays(afterDays)).Value > 0)
                        {
                            this.DoConcept(2032, this.RuleCalculateDate.AddDays(i)).Value = 1;
                        }
                        if (this.DoConcept(2033, this.RuleCalculateDate.AddDays(afterDays)).Value > 0)
                        {
                            this.DoConcept(2033, this.RuleCalculateDate.AddDays(i)).Value = 1;
                        }
                        if (this.DoConcept(2034, this.RuleCalculateDate.AddDays(afterDays)).Value > 0)
                        {
                            this.DoConcept(2034, this.RuleCalculateDate.AddDays(i)).Value = 1;
                        }
                        if (this.DoConcept(2035, this.RuleCalculateDate.AddDays(afterDays)).Value > 0)
                        {
                            this.DoConcept(2035, this.RuleCalculateDate.AddDays(i)).Value = 1;
                        }
                        this.ReCalculate(2005, this.RuleCalculateDate.AddDays(i));
                    }
                    //چون اولویت این قانون بعد از قانون 203 است
                    //برای روز جاری وظایف قانون 203 را اجرا میکنیم
                    if (this.DoConcept(2005).Value > 0)
                    {
                        if (x2 && this.DoConcept(24).Value > 0
                            || y2 && this.DoConcept(23).Value > 0
                            || z2 && this.DoConcept(25).Value > 0)
                        {
                            this.DoConcept(2).Value = this.DoConcept(6).Value;
                            this.DoConcept(4).Value = 1;
                        }
                    }
                }
            }
            GetLog(MyRule, " After Execute State:", 2, 4, 2005, 2031, 2032, 2033, 2034, 2035);
        }

        /// <summary>
        ///  اعمال ماموریت شبانه روزی در روزها تعطیل بین ماموریت شبانه روزی
        /// </summary>
        /// <param name="MyRule"></param>
        public virtual void R205(AssignedRule MyRule)
        {
            //2008 مفهوم مجموع ماموریت شبانه روزی 
            //2050 تعطیلات رسمی بین ماموریت شبانه روزی,ماموریت شبانه روزی محسوب شود
            //571 تعطیلات غیر رسمی بین ماموریت شبانه روزی,ماموریت شبانه روزی محسوب شود
            //572 روزهای غیر کاری بین ماموریت شبانه روزی,ماموریت شبانه روزی محسوب شود

            GetLog(MyRule, " Before Execute State:", 2008, 2041, 2042, 2043, 2044, 2045);
            if (this.DoConcept(2008).Value == 0
                && this.DoConcept(2008, this.RuleCalculateDate.AddDays(-1)).Value > 0)
            {
                bool x1 = Utility.ToBoolean(MyRule["Rasmi", this.RuleCalculateDate].ToInt());
                //bool x1 = this.DoConcept(2050).Value > 0 ? true : false;
                bool x2 = EngEnvironment.HasCalendar(this.RuleCalculateDate, "1");

                bool y1 = Utility.ToBoolean(MyRule["GheireRasmi", this.RuleCalculateDate].ToInt());
                //bool y1 = this.DoConcept(571).Value > 0 ? true : false;
                bool y2 = EngEnvironment.HasCalendar(this.RuleCalculateDate, "2");

                bool z1 = Utility.ToBoolean(MyRule["GheireKari", this.RuleCalculateDate].ToInt());
                //bool z1 = this.DoConcept(572).Value > 0 ? true : false;
                bool z2 = this.Person.GetShiftByDate(this.RuleCalculateDate).Value == 0 ? true : false;

                int afterDays = 0;
                int maxLoopcounter = 20;
                while ((x1 & x2) | (y1 & y2) | (z1 & z2))
                {
                    afterDays++;
                    maxLoopcounter--;
                    if (maxLoopcounter < 1)
                    {
                        return;
                    }

                    x2 = EngEnvironment.HasCalendar(this.RuleCalculateDate.AddDays(afterDays), "1");

                    y2 = EngEnvironment.HasCalendar(this.RuleCalculateDate.AddDays(afterDays), "2");

                    z2 = this.Person.GetShiftByDate(this.RuleCalculateDate.AddDays(afterDays)).Value == 0 ? true : false;
                }
                if (this.DoConcept(2008, this.RuleCalculateDate.AddDays(afterDays)).Value > 0)
                {
                    for (int i = 0; i < afterDays; i++)
                    {
                        if (this.DoConcept(2041, this.RuleCalculateDate.AddDays(afterDays)).Value > 0)
                        {
                            this.DoConcept(2041, this.RuleCalculateDate.AddDays(i)).Value = 1;
                        }
                        if (this.DoConcept(2042, this.RuleCalculateDate.AddDays(afterDays)).Value > 0)
                        {
                            this.DoConcept(2042, this.RuleCalculateDate.AddDays(i)).Value = 1;
                        }
                        if (this.DoConcept(2043, this.RuleCalculateDate.AddDays(afterDays)).Value > 0)
                        {
                            this.DoConcept(2043, this.RuleCalculateDate.AddDays(i)).Value = 1;
                        }
                        if (this.DoConcept(2044, this.RuleCalculateDate.AddDays(afterDays)).Value > 0)
                        {
                            this.DoConcept(2044, this.RuleCalculateDate.AddDays(i)).Value = 1;
                        }
                        if (this.DoConcept(2045, this.RuleCalculateDate.AddDays(afterDays)).Value > 0)
                        {
                            this.DoConcept(2045, this.RuleCalculateDate.AddDays(i)).Value = 1;
                        }
                        this.ReCalculate(2008, this.RuleCalculateDate.AddDays(i));
                    }
                }
                GetLog(MyRule, " After Execute State:", 2008, 2041, 2042, 2043, 2044, 2045);
            }
        }

        /// <summary>
        ///  اعمال اضافه کار کارتی بر روی اضافه کار مجاز ساعتی
        /// </summary>
        /// <param name="MyRule"></param>
        public virtual void R206(AssignedRule MyRule)
        {
            //4017 اضافه کار مجاز کارتی
            //4002 اضافه کارساعتي مجاز
            GetLog(MyRule, " Before Execute State:", 4002);
            ((PairableScndCnpValue)this.DoConcept(4002)).AppendPairs(this.DoConcept(4017));
            GetLog(MyRule, " After Execute State:", 4002);
        }

        /// <summary>
        ///  این قانون آخرین قانون است که اجرا میشود و باید کارهای آخر را انجام دهد
        /// </summary>
        /// <param name="MyRule"></param>
        public virtual void R207(AssignedRule MyRule)
        {
            //2 کارکرد خالص ساعتی 
            //4 کارکرد خالص روزانه
            //3028 غيبت ساعتی غیرمجاز
            //3004 غیبت ساعتی روزانه

            GetLog(MyRule, " After Execute State:", 4, 3028, 3004);
            if (this.DoConcept(2).Value == 0)
            {
                this.DoConcept(4).Value = 0;
            }
            if (this.DoConcept(3028).Value > 0 && this.DoConcept(2).Value == 0 && this.DoConcept(3004).Value == 0)
            {
                this.DoConcept(3004).Value = 1;
                this.DoConcept(3028).Value = 0;
            }
            GetLog(MyRule, " After Execute State:", 4, 3028, 3004);
        }

        /// <summary>
        ///  این قانون وضعیت رنگ روز را مشخص میکمد
        /// </summary>
        /// <param name="MyRule"></param>
        public virtual void R208(AssignedRule MyRule)
        {
            //5012 رنگ روز
            //تقويم تعطيل رسمي 1

            //3029 کد رنگ تعطیل رسمی
            //1015 کد رنگ تردد ناقص
            //103 کد رنگ غیبت روزانه
            //104 کد رنگ غیبت ساعتی
            //اگر عدد بیشتر از 200 بود بدین معناست که در روز تعطیل رسمی
            //یکی از موارد فوق اتفاق افتاده است


            GetLog(MyRule, " After Execute State:", 5012);

            #region Show Colors
            bool holiday = false, traffics = false, hourlyAbsence = false, dailyAbsence = false, permit = false;

            #region holiday

            if (MyRule.HasParameter("1th", this.RuleCalculateDate))
            {
                if (MyRule["1th", this.RuleCalculateDate].ToInt() == 1)
                {
                    holiday = true;
                }
            }
            else
            {
                holiday = true;
            }
            #endregion

            #region Tafics
            if (MyRule.HasParameter("2th", this.RuleCalculateDate))
            {
                if (MyRule["2th", this.RuleCalculateDate].ToInt() == 1)
                {
                    traffics = true;
                }
            }
            else
            {
                traffics = true;
            }
            #endregion

            #region hourly Absence
            if (MyRule.HasParameter("3th", this.RuleCalculateDate))
            {
                if (MyRule["3th", this.RuleCalculateDate].ToInt() == 1)
                {
                    hourlyAbsence = true;
                }
            }
            else
            {
                hourlyAbsence = true;
            }
            #endregion

            #region dailyAbsence
            if (MyRule.HasParameter("4th", this.RuleCalculateDate))
            {
                if (MyRule["4th", this.RuleCalculateDate].ToInt() == 1)
                {
                    dailyAbsence = true;
                }
            }
            else
            {
                dailyAbsence = true;
            }
            #endregion

            #region permits
            if (MyRule.HasParameter("5th", this.RuleCalculateDate))
            {
                if (MyRule["5th", this.RuleCalculateDate].ToInt() == 1)
                {
                    permit = true;
                }
            }
            else
            {
                permit = true;
            }
            #endregion

            #endregion

            this.DoConcept(5012).Value = 1;
            this.DoConcept(5013).Value = 5;
            this.DoConcept(5012).FromPairs = "";
            this.DoConcept(5012).ToPairs = "";

            ProceedTraffic ProceedTraffic = this.Person.GetProceedTraficByDate(this.RuleCalculateDate);
            if (ProceedTraffic.PairCount > 0 && !ProceedTraffic.IsFilled)
            {
                if (traffics)
                {
                    this.DoConcept(5012).FromPairs = "#FFFF40;";//Yellow
                    this.DoConcept(5012).ToPairs = String.Format("fa:{0};en:{1}", "تردد ناقص", "Uncomplete Traffic");
                }
            }
            else if (this.DoConcept(3004).Value > 0)
            {
                if (dailyAbsence)
                {
                    this.DoConcept(5012).FromPairs = this.DoConcept(3004).Concept.Color + ";";
                    this.DoConcept(5012).ToPairs = String.Format("fa:{0};en:{1}", this.DoConcept(3004).Concept.FnName, this.DoConcept(3004).Concept.EnName);
                }
            }
            else if (this.DoConcept(3028).Value > 0)
            {
                if (hourlyAbsence)
                {
                    this.DoConcept(5012).FromPairs = this.DoConcept(3028).Concept.Color + ";";
                    this.DoConcept(5012).ToPairs = String.Format("fa:{0};en:{1}", this.DoConcept(3028).Concept.FnName, this.DoConcept(3028).Concept.EnName);
                }
            }
            else
            {
                IList<Permit> permits = this.Person.GetPermitByDate(this.ConceptCalculateDate);
                if (permits.Count > 0)
                {
                    if (permit)
                    {
                        string faTitle = "";
                        string enTitle = "en:";
                        foreach (Permit p in permits)
                        {
                            foreach (PermitPair pair in p.Pairs)
                            {
                                if (faTitle.Length > 0)
                                    faTitle += " - ";
                                faTitle += pair.Precard.Name;
                            }
                        }
                        faTitle = "fa:" + faTitle;
                        this.DoConcept(5012).FromPairs = "#009900;";
                        this.DoConcept(5012).ToPairs = faTitle + ";" + enTitle;
                    }
                }
            }

            if (EngEnvironment.HasCalendar(this.RuleCalculateDate, "1")
                || this.Person.GetShiftByDate(this.RuleCalculateDate).Value == 0)
            {
                if (holiday)
                {
                    this.DoConcept(5012).Value = 2;
                    this.DoConcept(5012).FromPairs += "#FF0000";//Red
                }
            }

            GetLog(MyRule, " After Execute State:", 5012);

        }

        #endregion

        #region Concept Init

        /// <summary>قانون مقداردهی C7</summary>        
        public virtual void R220(AssignedRule MyRule)
        {
            this.DoConcept(7).Value = MyRule["First", this.RuleCalculateDate].ToInt();
        }

        /// <summary>قانون مقداردهی C20</summary>        
        public virtual void R223(AssignedRule MyRule)
        {
            this.DoConcept(1001).Value = MyRule["First", this.RuleCalculateDate].ToInt();
            this.Person.LeaveSetting.MinutesInDay = MyRule["First", this.RuleCalculateDate].ToInt();
        }

        /// <summary>قانون مقداردهی C30</summary>        
        public virtual void R224(AssignedRule MyRule)
        {
            this.DoConcept(2001).Value = MyRule["First", this.RuleCalculateDate].ToInt();
        }

        /// <summary>قانون مقداردهی C50</summary>        
        public virtual void R229(AssignedRule MyRule)
        {
            this.DoConcept(3012).Value = MyRule["First", this.RuleCalculateDate].ToInt();
        }

        /// <summary>قانون مقداردهی C51</summary>        
        public virtual void R230(AssignedRule MyRule)
        {
            throw new Exception("از رده خارج - بصورت پارامتر ارسال گردید");
            this.DoConcept(3013).Value = MyRule["First", this.RuleCalculateDate].ToInt();
        }

        /// <summary>قانون مقداردهی C53</summary>        
        public virtual void R231(AssignedRule MyRule)
        {
            this.DoConcept(3017).Value = MyRule["First", this.RuleCalculateDate].ToInt();
        }

        /// <summary>قانون مقداردهی C54</summary>        
        public virtual void R232(AssignedRule MyRule)
        {
            this.DoConcept(3018).Value = MyRule["First", this.RuleCalculateDate].ToInt();
        }

        /// <summary>قانون مقداردهی C55</summary>        
        public virtual void R233(AssignedRule MyRule)
        {
            this.DoConcept(3019).Value = MyRule["First", this.RuleCalculateDate].ToInt();
        }


        /// <summary>قانون مقداردهی C71</summary>        
        public virtual void R236(AssignedRule MyRule)
        {
            this.DoConcept(5003).Value = MyRule["First", this.RuleCalculateDate].ToInt();
        }

        /// <summary>قانون مقداردهی C86</summary>        
        public virtual void R237(AssignedRule MyRule)
        {
            throw new Exception("از رده خارج - بصورت پارامتر ارسال گردید");
            this.DoConcept(2011).Value = MyRule["First", this.RuleCalculateDate].ToInt();
        }

        /// <summary>قانون مقداردهی C87</summary>        
        public virtual void R238(AssignedRule MyRule)
        {
            this.DoConcept(2012).Value = 1;// MyRule["First", this.RuleCalculateDate].ToInt();
        }



        /// <summary>قانون مقداردهی C101</summary>        
        public virtual void R241(AssignedRule MyRule)
        {
            this.DoConcept(1014).Value = 1;// MyRule["First", this.RuleCalculateDate].ToInt();
        }

        /// <summary>قانون مقداردهی C102</summary>        
        public virtual void R242(AssignedRule MyRule)
        {
            this.DoConcept(1015).Value = MyRule["First", this.RuleCalculateDate].ToInt();
        }

        /// <summary>قانون مقداردهی C141</summary>        
        public virtual void R248(AssignedRule MyRule)
        {
            this.DoConcept(5007).Value = MyRule["First", this.RuleCalculateDate].ToInt();
        }

        /// <summary>قانون مقداردهی C163</summary>        
        public virtual void R249(AssignedRule MyRule)
        {
            this.DoConcept(5011).Value = MyRule["First", this.RuleCalculateDate].ToInt();
        }


        /// <summary>قانون مقداردهی C134</summary>        
        public virtual void R251(AssignedRule MyRule)
        {
            throw new Exception("از رده خارج - تکراری");
            this.DoConcept(1021).Value = 1;// MyRule["First", this.RuleCalculateDate].ToInt();
        }

        /// <summary>قانون مقداردهی C135</summary>        
        public virtual void R252(AssignedRule MyRule)
        {
            this.DoConcept(1022).Value = MyRule["First", this.RuleCalculateDate].ToInt();
        }

        /// <summary>قانون مقداردهی C341</summary>        
        public virtual void R253(AssignedRule MyRule)
        {
            this.DoConcept(341).Value = MyRule["First", this.RuleCalculateDate].ToInt();
        }

        /// <summary>قانون مقداردهی C346</summary>        
        public virtual void R254(AssignedRule MyRule)
        {
            ((PairableScndCnpValue)this.DoConcept(21)).AddPairs(Operation.Intersect(this.DoConcept(1),
                                                  new PairableScndCnpValuePair(MyRule["First", this.RuleCalculateDate].ToInt(), MyRule["Second", this.RuleCalculateDate].ToInt())));
        }

        /// <summary>قانون مقداردهی C377</summary>        
        public virtual void R257(AssignedRule MyRule)
        {
            this.DoConcept(2029).Value = 1;// MyRule["First", this.RuleCalculateDate].ToInt();
        }

        /// <summary>قانون مقداردهی C536</summary>        
        public virtual void R258(AssignedRule MyRule)
        {
            this.DoConcept(1083).Value = MyRule["First", this.RuleCalculateDate].ToInt();
        }

        /// <summary>قانون مقداردهی C537</summary>        
        public virtual void R259(AssignedRule MyRule)
        {
            this.DoConcept(1084).Value = MyRule["First", this.RuleCalculateDate].ToInt();
        }

        /// <summary>قانون مقداردهی C538</summary>        
        public virtual void R260(AssignedRule MyRule)
        {
            this.DoConcept(1085).Value = MyRule["First", this.RuleCalculateDate].ToInt();
        }

        /// <summary>قانون مقداردهی C539</summary>        
        public virtual void R261(AssignedRule MyRule)
        {
            this.DoConcept(1086).Value = MyRule["First", this.RuleCalculateDate].ToInt();
        }

        /// <summary>قانون مقداردهی C540</summary>        
        public virtual void R262(AssignedRule MyRule)
        {
            this.DoConcept(1087).Value = MyRule["First", this.RuleCalculateDate].ToInt();
        }

        /// <summary>قانون مقداردهی LeaveSetting.UseFutureMounthLeave</summary>        
        public virtual void R263(AssignedRule MyRule)
        {
            this.Person.LeaveSetting.UseFutureMounthLeave = true;
        }



        #endregion


        #endregion

        #region IDisposable Members

        public void Dispose()
        {
            //this.ConceptList.Clear();                    
        }

        #endregion
    }
}
