using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.OleDb;
using System.Configuration;

namespace AtlasTrafficReader.Classes
{
    class XLS
    {
        public void NewFiles()
        {
            try
            {
                string[] files = System.IO.Directory.GetFiles(ConfigurationManager.AppSettings["FolderPath"]);
                foreach (string file in files)
                {
                    if (!IsRegistredFile(file))
                    {
                        ReadFile(file);
                    }
                }
            }
            catch (Exception ex)
            {
                System.Windows.Forms.MessageBox.Show(ex.Message,"NewFile");
            }
        }

        private bool IsRegistredFile(string fileName)
        {
            var logDB = new LogDBEntities();
            if (logDB.TA_TrafficLog.Count(m => m.FileName == fileName) > 0)
                return true;
            else
                return false;
        }

        private void ReadFile(string fileName)
        {
            try
            {
                List<Traffics> traffics = new List<Traffics>();
                string StrCon = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source= " + fileName + ";Extended Properties=Excel 8.0;";
                OleDbConnection oleCon = new OleDbConnection(StrCon);
                oleCon.Open();
                OleDbDataAdapter da = new OleDbDataAdapter("select * from [" + ConfigurationManager.AppSettings["SheetName"] + "$]", oleCon);
                DataSet ds = new DataSet();
                da.Fill(ds);
                int delrow = 4;
                // ذخیره رکوردها در لیست
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    delrow--;
                    if (delrow <= 0)
                    {
                        Traffics t = new Traffics();
                        t.BarCode = row[2] != null ? row[2].ToString() : "";
                        t.Date = row[0] != null ? Converter.ConvertToPersian(row[0].ToString()) : DateTime.MinValue;
                        t.FirstIn = row[5] != null ? Converter.ConvertToMinute(row[5].ToString()) : 0;
                        t.LastOut = row[6] != null ? Converter.ConvertToMinute(row[6].ToString()) : 0;
                        traffics.Add(t);
                    }
                }
                oleCon.Close();
                // ---------------------
                foreach (Traffics traffic in traffics)
                {
                    RegisterRecord(traffic);
                }

                var logDB = new LogDBEntities();
                TA_TrafficLog tl = new TA_TrafficLog();
                tl.FileName = fileName;
                tl.Date = DateTime.Now;
                logDB.TA_TrafficLog.AddObject(tl);
                logDB.SaveChanges();
            }
            catch (Exception ex)
            {
                System.Windows.Forms.MessageBox.Show(ex.Message,"ReadFile");
            }
        }

        private bool RegisterRecord(Traffics traffic)
        {
            try
            {
                var falatGTS = new FalatGTSEntities();
                // رکورد تکراری
                decimal personId = (from items in falatGTS.TA_Person
                                    where items.Prs_Barcode == traffic.BarCode
                                    select (decimal)items.Prs_ID).Single();
                if (falatGTS.TA_BaseTraffic.Count(w => w.BasicTraffic_PersonID == personId && w.BasicTraffic_Date == traffic.Date && (w.BasicTraffic_Time == traffic.FirstIn || w.BasicTraffic_Time == traffic.LastOut)) > 0)
                    return false;
                // ---------------
                // ذخیره رکورد
                TA_BaseTraffic baseTrafficFI = new TA_BaseTraffic();
                TA_BaseTraffic baseTrafficLO = new TA_BaseTraffic();
                if (traffic.FirstIn != 0)
                {
                    baseTrafficFI.BasicTraffic_Time = traffic.FirstIn;
                    baseTrafficFI.BasicTraffic_PrecardId = 8832;
                    baseTrafficFI.BasicTraffic_PersonID = personId;
                    baseTrafficFI.BasicTraffic_Date = traffic.Date;
                    baseTrafficFI.BasicTraffic_Used = false;
                    baseTrafficFI.BasicTraffic_Active = true;
                    baseTrafficFI.BasicTraffic_Manual = false;
                    baseTrafficFI.BasicTraffic_State = true;
                    baseTrafficFI.BasicTraffic_ReportsListId = 0;
                    baseTrafficFI.BasicTraffic_OperatorPersonID = null;
                    baseTrafficFI.BasicTraffic_Description = null;
                    baseTrafficFI.BasicTraffic_ClockCustomCode = null;
                }
                if (traffic.LastOut != 0)
                {
                    baseTrafficLO.BasicTraffic_Time = traffic.FirstIn;
                    baseTrafficLO.BasicTraffic_PrecardId = 8832;
                    baseTrafficLO.BasicTraffic_PersonID = personId;
                    baseTrafficLO.BasicTraffic_Date = traffic.Date;
                    baseTrafficLO.BasicTraffic_Used = false;
                    baseTrafficLO.BasicTraffic_Active = true;
                    baseTrafficLO.BasicTraffic_Manual = false;
                    baseTrafficLO.BasicTraffic_State = true;
                    baseTrafficLO.BasicTraffic_ReportsListId = 0;
                    baseTrafficLO.BasicTraffic_OperatorPersonID = null;
                    baseTrafficLO.BasicTraffic_Description = null;
                    baseTrafficLO.BasicTraffic_ClockCustomCode = null;
                }
                if (baseTrafficFI != null)
                    falatGTS.TA_BaseTraffic.AddObject(baseTrafficFI);
                if (baseTrafficLO != null)
                    falatGTS.TA_BaseTraffic.AddObject(baseTrafficLO);
                falatGTS.SaveChanges();
                System.Windows.Forms.MessageBox.Show("success", "Save");
                return true;
            }
            catch (Exception ex)
            {
                System.Windows.Forms.MessageBox.Show(ex.Message, "RegisterRecord");
                return false;
            }
        }
    }
}
