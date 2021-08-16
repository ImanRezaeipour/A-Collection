---------------------------------------------
حداقل اضافه کاری قبل از وقت - پارامتر پویا
---------------------------------------------
var personParam = calculator.Person.PersonTASpec.GetParamValue(calculator.Person.ID, "MINEGAV", calculator.RuleCalculateDate);
if (personParam != null && calculator.DoConcept(4008).Value < System.Convert.ToInt32(personParam.Value) )
{
	((PairableScndCnpValue)calculator.DoConcept(4002)).AddPairs(Operation.Differance(calculator.DoConcept(4002), calculator.DoConcept(4008)));
	((PairableScndCnpValue)calculator.DoConcept(4003)).AddPairs(calculator.DoConcept(4008));
	((PairableScndCnpValue)calculator.DoConcept(4008)).ClearPairs();
	calculator.ReCalculate(13);
}
---------------------------------------------
حداقل اضافه کاری بعد از وقت - پارامتر پویا
---------------------------------------------
var personParam = calculator.Person.PersonTASpec.GetParamValue(calculator.Person.ID, "MINEBAV", calculator.RuleCalculateDate);
if (personParam != null && calculator.DoConcept(4007).Value < System.Convert.ToInt32(personParam.Value))
{
	((PairableScndCnpValue)calculator.DoConcept(4002)).AddPairs(Operation.Differance(calculator.DoConcept(4002), calculator.DoConcept(4007)));
	((PairableScndCnpValue)calculator.DoConcept(4003)).AddPairs(calculator.DoConcept(4007));
	((PairableScndCnpValue)calculator.DoConcept(4007)).ClearPairs();
	calculator.ReCalculate(13);
}
---------------------------------------------
حداکثر اضافه کاری قبل از وقت - پارامتر پویا 
---------------------------------------------
var personParam = calculator.Person.PersonTASpec.GetParamValue(calculator.Person.ID, "MAXEGAV", calculator.RuleCalculateDate);
if (personParam != null && calculator.DoConcept(4008).Value > System.Convert.ToInt32(personParam.Value))
{
	int notAllowValue = calculator.DoConcept(4008).Value - System.Convert.ToInt32(personParam.Value);
	PairableScndCnpValue notAllow = new PairableScndCnpValue();
	foreach (PairableScndCnpValuePair pair in ((PairableScndCnpValue)calculator.DoConcept(4008)).Pairs.OrderBy(x => x.From))
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
	((PairableScndCnpValue)calculator.DoConcept(4003)).AppendPairs(Operation.Intersect(calculator.DoConcept(4002), notAllow));
	((PairableScndCnpValue)calculator.DoConcept(4002)).AddPairs(Operation.Differance(calculator.DoConcept(4002), notAllow));
	calculator.ReCalculate(13,4008);
}
---------------------------------------------
حداکثر اضافه کاری بعد از وقت - پارامتر پویا
---------------------------------------------
var personParam = calculator.Person.PersonTASpec.GetParamValue(calculator.Person.ID, "MAXEBAV", calculator.RuleCalculateDate);
if (personParam != null && calculator.DoConcept(4007).Value > System.Convert.ToInt32(personParam.Value))
{
	int notAllowValue = calculator.DoConcept(4007).Value - System.Convert.ToInt32(personParam.Value);
	PairableScndCnpValue notAllow = new PairableScndCnpValue();
	foreach (PairableScndCnpValuePair pair in ((PairableScndCnpValue)calculator.DoConcept(4007)).Pairs.OrderByDescending(x => x.From))
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
	((PairableScndCnpValue)calculator.DoConcept(4003)).AppendPairs(Operation.Intersect(calculator.DoConcept(4002), notAllow));
	((PairableScndCnpValue)calculator.DoConcept(4002)).AddPairs(Operation.Differance(calculator.DoConcept(4002), notAllow));
	calculator.ReCalculate(13,4007);
}
---------------------------------------------
حداکثر اضافه کاری روز عادی - پارامتر پویا
---------------------------------------------
var personParam = calculator.Person.PersonTASpec.GetParamValue(calculator.Person.ID, "MAXERA", calculator.RuleCalculateDate);
if (personParam != null && calculator.DoConcept(4015).Value == 1)
	return;
if (personParam != null && calculator.Person.GetShiftByDate(calculator.RuleCalculateDate).Value > 0
	 && calculator.DoConcept(4002).Value > System.Convert.ToInt32(personParam.Value))
{
	int notAllowedValue = calculator.DoConcept(4002).Value - System.Convert.ToInt32(personParam.Value);
	foreach (IPair pair in ((PairableScndCnpValue)calculator.DoConcept(4002)).Pairs)
	{
		if (pair.Value - notAllowedValue > 0)
		{
			IPair notAllowedPair = new PairableScndCnpValuePair(pair.To - notAllowedValue, pair.To);
			((PairableScndCnpValue)calculator.DoConcept(4003)).AppendPair(notAllowedPair);
			pair.To -= notAllowedValue;
			calculator.DoConcept(4002).Value = ((PairableScndCnpValue)calculator.DoConcept(4002)).PairValues;
			break;
		}
		else if (pair.Value - notAllowedValue == 0)
		{
			((PairableScndCnpValue)calculator.DoConcept(4003)).AppendPair(pair);
			pair.From = pair.To = 0;
			calculator.DoConcept(4002).Value = ((PairableScndCnpValue)calculator.DoConcept(4002)).PairValues;
			break;
		}
		else
		{
			((PairableScndCnpValue)calculator.DoConcept(4003)).AppendPair(pair);
			notAllowedValue -= pair.Value;
			pair.From = pair.To = 0;
			calculator.DoConcept(4002).Value = ((PairableScndCnpValue)calculator.DoConcept(4002)).PairValues;
		}
	}
	calculator.ReCalculate(13);
}
---------------------------------------------
حداکثر اضافه کاری روز غیر کاری - پارامتر پویا
---------------------------------------------
var personParam = calculator.Person.PersonTASpec.GetParamValue(calculator.Person.ID, "MAXERG", calculator.RuleCalculateDate);
if (personParam != null && calculator.DoConcept(4015).Value == 1)
	return;
if (personParam != null && calculator.Person.GetShiftByDate(calculator.RuleCalculateDate).Value == 0
	&& calculator.DoConcept(4002).Value > System.Convert.ToInt32(personParam.Value))
{
	int notAllowedValue = calculator.DoConcept(4002).Value - System.Convert.ToInt32(personParam.Value);
	foreach (IPair pair in ((PairableScndCnpValue)calculator.DoConcept(4002)).Pairs)
	{
		if (pair.Value - notAllowedValue > 0)
		{
			IPair notAllowedPair = new PairableScndCnpValuePair(pair.To - notAllowedValue, pair.To);
			((PairableScndCnpValue)calculator.DoConcept(4003)).AppendPair(notAllowedPair);
			pair.To -= notAllowedValue;
			calculator.DoConcept(4002).Value = ((PairableScndCnpValue)calculator.DoConcept(4002)).PairValues;
			break;
		}
		else if (pair.Value - notAllowedValue == 0)
		{
			((PairableScndCnpValue)calculator.DoConcept(4003)).AppendPair(pair);
			pair.From = pair.To = 0;
			calculator.DoConcept(4002).Value = ((PairableScndCnpValue)calculator.DoConcept(4002)).PairValues;
			break;
		}
		else
		{
			((PairableScndCnpValue)calculator.DoConcept(4003)).AppendPair(pair);
			notAllowedValue -= pair.Value;
			pair.From = pair.To = 0;
			calculator.DoConcept(4002).Value = ((PairableScndCnpValue)calculator.DoConcept(4002)).PairValues;
		}
	}
	calculator.ReCalculate(13);
}
---------------------------------------------
حداکثر اضافه کاری ماهانه ساعتی - پارامتر پویا
---------------------------------------------
var personParam = calculator.Person.PersonTASpec.GetParamValue(calculator.Person.ID, "MAXEMS", calculator.RuleCalculateDate);
if (personParam != null)
{
	calculator.DoConcept(4018).Value = System.Convert.ToInt32(personParam.Value);
	if (calculator.DoConcept(4005).Value > System.Convert.ToInt32(personParam.Value))
	{
		calculator.DoConcept(3).Value -= calculator.DoConcept(4005).Value - System.Convert.ToInt32(personParam.Value);
		calculator.DoConcept(4006).Value += calculator.DoConcept(4005).Value - System.Convert.ToInt32(personParam.Value);
		calculator.DoConcept(4005).Value = System.Convert.ToInt32(personParam.Value);
	}
}
---------------------------------------------
حداکثر اضافه کار تعطیل ماهانه - پارامتر پویا
---------------------------------------------
var personParam = calculator.Person.PersonTASpec.GetParamValue(calculator.Person.ID, "MAXETM", calculator.RuleCalculateDate);
if (personParam != null && System.Convert.ToInt32(personParam.Value) > 0
	 && calculator.DoConcept(4010).Value > System.Convert.ToInt32(personParam.Value) * HourMin)
{
	int tmp = calculator.DoConcept(4010).Value - System.Convert.ToInt32(personParam.Value) * HourMin;
	calculator.DoConcept(3).Value -= tmp;
	calculator.DoConcept(4005).Value -= tmp;
	calculator.DoConcept(4006).Value += tmp;
	calculator.DoConcept(4010).Value = System.Convert.ToInt32(personParam.Value) * HourMin;
}
---------------------------------------------