using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AtlasTrafficReader.Classes
{
    class Traffics
    {
        public string BarCode { get; set; }
        public DateTime Date { get; set; }
        public int FirstIn { get; set; }
        public int LastOut { get; set; }
    }
}
