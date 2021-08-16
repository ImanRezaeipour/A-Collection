using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ImportExcell
{
    public static class ExcelDataTable
    {
        private static DataTable _dtExcell=new DataTable();
        public static DataTable dtExcel {
            get { return _dtExcell; }
            set { _dtExcell = value; } }

        
    }
}
