public virtual void R6004(AssignedRule MyRule)
        {
            //اضافه کار خالص ساعتي 56
            //4002 اضافه کار ساعتي مجاز
            //4003 اضافه کار ساعتي غيرمجاز
            //4008 اضافه کارساعتي قبل ازوقت

			MyRule["First", calculator.RuleCalculateDate].ToInt()
			
			calculator.Person.PersonTASpec.GetParamValue(calculator.Person.ID, "", calculator.RuleCalculateDate)
			
			
            GetLog(MyRule, " Before Execute State:", 4002, 4003, 4008, 13);
            if (calculator.DoConcept(4008).Value < calculator.Person.PersonTASpec.GetParamValue(calculator.Person.ID, "", calculator.RuleCalculateDate).ToInt())
            {
                ((PairableScndCnpValue)calculator.DoConcept(4002)).AddPairs(Operation.Differance(calculator.DoConcept(4002), calculator.DoConcept(4008)));
                ((PairableScndCnpValue)calculator.DoConcept(4003)).AddPairs(calculator.DoConcept(4008));
                ((PairableScndCnpValue)calculator.DoConcept(4008)).ClearPairs();
                calculator.ReCalculate(13);
            }
            GetLog(MyRule, " After Execute State:", 4002, 4003, 4008, 13);
        }


----------------------------------


public virtual void R6005(AssignedRule MyRule)
        {
            GetLog(MyRule, " Before Execute State:", 4002, 4003, 4007, 13);

            //اضافه کار خالص ساعتي 56
            //4002 اضافه کار ساعتي مجاز
            //4003 اضافه کار ساعتي غيرمجاز
            //4007 اضافه کارساعتي بعد ازوقت

            if (this.DoConcept(4007).Value < MyRule["First", this.RuleCalculateDate].ToInt())
            {
                ((PairableScndCnpValue)this.DoConcept(4002)).AddPairs(Operation.Differance(this.DoConcept(4002), this.DoConcept(4007)));
                ((PairableScndCnpValue)this.DoConcept(4003)).AddPairs(this.DoConcept(4007));
                ((PairableScndCnpValue)this.DoConcept(4007)).ClearPairs();
                this.ReCalculate(13);
            }
            GetLog(MyRule, " After Execute State:", 4002, 4003, 4007, 13);
        }


------------------------------------


public virtual void R6006(AssignedRule MyRule)
        {
            GetLog(MyRule, " Before Execute State:", 4002, 4003, 4008, 13);

            //اضافه کار خالص ساعتي 56
            //4002 اضافه کار ساعتي مجاز
            //4003 اضافه کار ساعتي غيرمجاز
            //4008 اضافه کارساعتي قبل ازوقت

            if (this.DoConcept(4008).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                int notAllowValue = this.DoConcept(4008).Value - MyRule["First", this.RuleCalculateDate].ToInt();
                PairableScndCnpValue notAllow = new PairableScndCnpValue();
                foreach (PairableScndCnpValuePair pair in ((PairableScndCnpValue)this.DoConcept(4008)).Pairs.OrderBy(x => x.From))
                {
                    if (pair.Value >= notAllowValue)
                    {
                        IPair notAloowPair = new PairableScndCnpValuePair(pair.From, pair.From + notAllowValue);
                        notAllow.Pairs.Add(notAloowPair);
                        notAllowValue = 0;
                        break;
                    }
                    else
                    {
                        notAllowValue -= pair.Value;
                        notAllow.Pairs.Add(pair);
                    }
                }
                ((PairableScndCnpValue)this.DoConcept(4003)).AppendPairs(Operation.Intersect(this.DoConcept(4002), notAllow));
                ((PairableScndCnpValue)this.DoConcept(4002)).AddPairs(Operation.Differance(this.DoConcept(4002), notAllow));
                this.ReCalculate(13,4008);
            }

            GetLog(MyRule, " After Execute State:", 4002, 4003, 4008, 13);
        }

------------------------------------------------------

public virtual void R6007(AssignedRule MyRule)
        {
            GetLog(MyRule, " Before Execute State:", 4002, 4003, 4007, 13);

            //اضافه کار خالص ساعتي 56
            //4002 اضافه کار ساعتي مجاز
            //4003 اضافه کار ساعتي غيرمجاز
            //4007 اضافه کارساعتي بعد ازوقت

            if (this.DoConcept(4007).Value > MyRule["First", this.RuleCalculateDate].ToInt())
            {
                int notAllowValue = this.DoConcept(4007).Value - MyRule["First", this.RuleCalculateDate].ToInt();
                PairableScndCnpValue notAllow = new PairableScndCnpValue();
                foreach (PairableScndCnpValuePair pair in ((PairableScndCnpValue)this.DoConcept(4007)).Pairs.OrderByDescending(x => x.From))
                {
                    if (pair.Value >= notAllowValue)
                    {
                        IPair notAloowPair = new PairableScndCnpValuePair(pair.To - notAllowValue, pair.To);
                        notAllow.Pairs.Add(notAloowPair);
                        notAllowValue = 0;
                        break;
                    }
                    else
                    {
                        notAllowValue -= pair.Value;
                        notAllow.Pairs.Add(pair);
                    }
                }
                ((PairableScndCnpValue)this.DoConcept(4003)).AppendPairs(Operation.Intersect(this.DoConcept(4002), notAllow));
                ((PairableScndCnpValue)this.DoConcept(4002)).AddPairs(Operation.Differance(this.DoConcept(4002), notAllow));
                this.ReCalculate(13,4007);
            }
            GetLog(MyRule, " After Execute State:", 4002, 4003, 4007, 13);
        }

-------------------------------------------------------------------

public virtual void R6008(AssignedRule MyRule)
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

-------------------------------------------------

public virtual void R6009(AssignedRule MyRule)
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

--------------------------------------------------------

public virtual void R6010(AssignedRule MyRule)
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
            }
            GetLog(MyRule, " After Execute State:", 3, 4005, 4006, 4018);
        }
--------------------------------------------------------------
public virtual void R6011(AssignedRule MyRule)
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