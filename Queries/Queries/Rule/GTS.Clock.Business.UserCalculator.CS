
using System;
using System.Collections.Generic;
using System.Linq;
using GTS.Clock.Model;
using GTS.Clock.Model.ELE;
using GTS.Clock.Model.Concepts;
using GTS.Clock.Model.Concepts.Operations;
using GTS.Clock.Infrastructure.Utility;

namespace GTS.Clock.Business.DesignedCalculator
{
    public static class DesignedRuleCalculator
    {
        //#region Rules
        
        /// <summary>
        /// ##SUMMARY###
        /// </summary>
        /// <param name="MyRule"></param>
        public static void R6514(this GTS.Clock.Business.Calculator.RuleCalculator calculator, AssignedRule MyRule)
        {
             if( calculator.DoConcept(4008).Value  < Utility.ToInteger( calculator.Person.PersonTASpec.GetParamValue(calculator.Person.ID, "MINEGAV", calculator.RuleCalculateDate).Value ) ) {  ((PairableScndCnpValue) calculator.DoConcept(4002)) .AddPairs( Operation.Differance( ((PairableScndCnpValue)calculator.DoConcept(4002))  ,  ((PairableScndCnpValue)calculator.DoConcept(4008))  ) )  ;  ((PairableScndCnpValue) calculator.DoConcept(4003)) .AddPairs( ((PairableScndCnpValue)calculator.DoConcept(4008))  )  ;  ((PairableScndCnpValue)calculator.DoConcept(4008)) .ClearPairs()   ;  calculator.ReCalculate(13) ; }
        }
            
        /// <summary>
        /// ##SUMMARY###
        /// </summary>
        /// <param name="MyRule"></param>
        public static void R6506(this GTS.Clock.Business.Calculator.RuleCalculator calculator, AssignedRule MyRule)
        {
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
        }
            
        /// <summary>
        /// ##SUMMARY###
        /// </summary>
        /// <param name="MyRule"></param>
        public static void R6507(this GTS.Clock.Business.Calculator.RuleCalculator calculator, AssignedRule MyRule)
        {
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
        }
            
        /// <summary>
        /// ##SUMMARY###
        /// </summary>
        /// <param name="MyRule"></param>
        public static void R6508(this GTS.Clock.Business.Calculator.RuleCalculator calculator, AssignedRule MyRule)
        {
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
        }
            
        /// <summary>
        /// ##SUMMARY###
        /// </summary>
        /// <param name="MyRule"></param>
        public static void R6509(this GTS.Clock.Business.Calculator.RuleCalculator calculator, AssignedRule MyRule)
        {
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
        }
            
        /// <summary>
        /// ##SUMMARY###
        /// </summary>
        /// <param name="MyRule"></param>
        public static void R6510(this GTS.Clock.Business.Calculator.RuleCalculator calculator, AssignedRule MyRule)
        {
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
        }
            
        /// <summary>
        /// ##SUMMARY###
        /// </summary>
        /// <param name="MyRule"></param>
        public static void R6511(this GTS.Clock.Business.Calculator.RuleCalculator calculator, AssignedRule MyRule)
        {
             var personParam = calculator.Person.PersonTASpec.GetParamValue(calculator.Person.ID, "MAXETM", calculator.RuleCalculateDate);
if (personParam != null && System.Convert.ToInt32(personParam.Value) > 0
	 && calculator.DoConcept(4010).Value > System.Convert.ToInt32(personParam.Value) * 60)
{
	int tmp = calculator.DoConcept(4010).Value - System.Convert.ToInt32(personParam.Value) * 60;
	calculator.DoConcept(3).Value -= tmp;
	calculator.DoConcept(4005).Value -= tmp;
	calculator.DoConcept(4006).Value += tmp;
	calculator.DoConcept(4010).Value = System.Convert.ToInt32(personParam.Value) * 60;
}
        }
            
        /// <summary>
        /// ##SUMMARY###
        /// </summary>
        /// <param name="MyRule"></param>
        public static void R6505(this GTS.Clock.Business.Calculator.RuleCalculator calculator, AssignedRule MyRule)
        {
             var personParam = calculator.Person.PersonTASpec.GetParamValue(calculator.Person.ID, "MINEBAV", calculator.RuleCalculateDate);
if (personParam != null && calculator.DoConcept(4007).Value < System.Convert.ToInt32(personParam.Value))
{
	((PairableScndCnpValue)calculator.DoConcept(4002)).AddPairs(Operation.Differance(calculator.DoConcept(4002), calculator.DoConcept(4007)));
	((PairableScndCnpValue)calculator.DoConcept(4003)).AddPairs(calculator.DoConcept(4007));
	((PairableScndCnpValue)calculator.DoConcept(4007)).ClearPairs();
	calculator.ReCalculate(13);
}
        }
            
        /// <summary>
        /// ##SUMMARY###
        /// </summary>
        /// <param name="MyRule"></param>
        public static void R6504(this GTS.Clock.Business.Calculator.RuleCalculator calculator, AssignedRule MyRule)
        {
             var personParam = calculator.Person.PersonTASpec.GetParamValue(calculator.Person.ID, "MINEGAV", calculator.RuleCalculateDate);
if (personParam != null && calculator.DoConcept(4008).Value < System.Convert.ToInt32(personParam.Value) )
{
	((PairableScndCnpValue)calculator.DoConcept(4002)).AddPairs(Operation.Differance(calculator.DoConcept(4002), calculator.DoConcept(4008)));
	((PairableScndCnpValue)calculator.DoConcept(4003)).AddPairs(calculator.DoConcept(4008));
	((PairableScndCnpValue)calculator.DoConcept(4008)).ClearPairs();
	calculator.ReCalculate(13);
}
        }
            
        //#endregion
    }

    public static class DesignedConceptCalculator
    {
       #region Concepts
       
       #endregion

    }

}