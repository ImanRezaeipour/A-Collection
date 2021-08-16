using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AtlasTrafficReader.Classes
{
    public class Converter
    {
        public static DateTime ConvertToPersian(string dateTime)
        {
            if (dateTime == "")
                dateTime = "01/01/01";
            string[] time = new string[3];
            time = dateTime.Split('/');
            int day = Convert.ToInt32(time[0]);
            int month = Convert.ToInt32(time[1]);
            int year = Convert.ToInt32("13" + time[2]);
            System.Globalization.PersianCalendar dc = new System.Globalization.PersianCalendar();
            return dc.ToDateTime(year, month, day, 0, 0, 0, 0);
        }

        public static int ConvertToMinute(string time)
        {
            if (time == "")
                time = "00:00";
            string[] t = new string[2];
            t = time.Split(':');
            int hour = Convert.ToInt32(t[0]);
            int minute = Convert.ToInt32(t[1]);
            return (hour * 60) + minute;
        }
    }
}
