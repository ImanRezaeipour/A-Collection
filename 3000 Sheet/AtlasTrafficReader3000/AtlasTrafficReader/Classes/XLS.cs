using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Linq;

namespace AtlasTrafficReader.Classes
{
    internal class XLS
    {
        private int _recordCount = 0;

        public int RecordCount
        {
            get
            {
                return _recordCount;
            }
            set
            {
                _recordCount = value;
            }
        }

        //public List<SP> sp = new List<SP>();


        public void NewFiles()
        {
            if (Directory.Exists(ConfigurationManager.AppSettings["FolderPath"]))
            {
                string[] files = Directory.GetFiles(ConfigurationManager.AppSettings["FolderPath"]);
                foreach (string file in files)
                {
                    try
                    {
                        if (!IsRegistredFile(file))
                        {
                            Classes.Info.File = file;
                            GetExcelSheetNames(file);

                            Classes.Info.Progress = 0;

                            // ثبت در فایل
                            using (StreamWriter stream = new StreamWriter(ConfigurationManager.AppSettings["ImportedPath"] + ConfigurationManager.AppSettings["LogFile"], true, System.Text.Encoding.UTF8))
                            {
                                stream.WriteLine(file);
                            }

                            // انتقال فایل
                            try
                            {
                                System.IO.File.Copy(file, ConfigurationManager.AppSettings["ImportedPath"] + new FileInfo(file).Name, true);
                                System.IO.File.Delete(file);
                            }
                            catch (Exception ex)
                            {
                                LogError("Action: MoveFile; Error: " + ex, file);
                            };
                        }
                    }
                    catch (Exception ex)
                    {
                        LogError("Method: NewFiles; Error: " + ex, file);
                        //Info.Message+="Method: NewFiles; Error: " + ex.Message+"; FileName: "+ file+"\n";
                    }
                }
            }
        }

        private bool IsRegistredFile(string fileName)
        {
            try
            {
                using (StreamReader reader = new StreamReader(ConfigurationManager.AppSettings["ImportedPath"] + ConfigurationManager.AppSettings["LogFile"], System.Text.Encoding.UTF8))
                {
                    List<string> files = new List<string>();
                    while (!reader.EndOfStream)
                    {
                        files.Add(reader.ReadLine());
                    }
                    if (files.Contains(fileName))
                        return true;
                    return false;
                }
            }
            catch (Exception ex)
            {
                //var logDB = new LogDBEntities();
                //if (logDB.TA_TrafficLog.Count(m => m.FileName == fileName) > 0) return true;
                return false;
            }
        }

        private void GetExcelSheetNames(string excelFile)
        {
            OleDbConnection objConn = null;
            DataTable dt = null;
            try
            {
                String connString = "Provider=Microsoft.Jet.OLEDB.4.0;" +
                                    "Data Source=" + excelFile + ";Extended Properties=Excel 8.0;";
                objConn = new OleDbConnection(connString);
                objConn.Open();
                dt = objConn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
                if (dt == null)
                {
                    return;
                }
                String[] excelSheets = new String[dt.Rows.Count];
                int i = 0;
                foreach (DataRow row in dt.Rows)
                {
                    excelSheets[i] = row["TABLE_NAME"].ToString();
                    i++;
                }

                Classes.Info.SheetRemain = excelSheets.Length;
                // BackgroundWorker Progress value
                int sheetPercent = 1, progressValue = 1;
                for (int j = 0; j < excelSheets.Length; j++)
                {
                    ReadSheet(excelFile, excelSheets[j]);

                    Classes.Info.SheetRemain--;

                    sheetPercent = excelSheets.Length / 100;
                    progressValue = (j) / sheetPercent;
                    Info.Progress = progressValue;
                }
            }
            catch (Exception ex)
            {
                LogError("Method: GetExcelSheetNames; Error: " + ex, excelFile);
                //Info.Message += "Method: GetExcelSheetNames; Error: " + ex.Message + "; FileName: " + excelFile + "\n";
            }
            finally
            {
                if (objConn != null)
                {
                    objConn.Close();
                    objConn.Dispose();
                }
                if (dt != null)
                {
                    dt.Dispose();
                }
            }
        }

        private bool ReadSheet(string fileName, string sheetName)
        {
            // ایا بارکد وجود دارد
            var falatGTS = new FalatGTSEntities();
            string bCode = sheetName != null ? sheetName.Remove(sheetName.Length - 2).Remove(0, 1) : "";
            decimal personId = 0;
            try
            {
                personId =
                    (from items in falatGTS.TA_Person
                     where (items.Prs_Barcode == bCode || items.Prs_CardNum == bCode)
                     select (decimal)items.Prs_ID).Single();
            }
            catch (Exception ex)
            {
                // ثبت در فایل
                using (StreamWriter stream = new StreamWriter(ConfigurationManager.AppSettings["ImportedPath"] + "NOT-FOUND-BARCODE-IN-" + new FileInfo(fileName).Name, true, System.Text.Encoding.UTF8))
                {
                    stream.WriteLine(bCode);
                }

                LogError("Method: ReadSheet; Barcode: " + bCode + "; Error: Barcode or CardNum not found.", fileName);
               // Info.Message += "Method: ReadSheet; Barcode: " + bCode + "; Error: Barcode or CardNum not found." + "; FileName: " + fileName + "\n";
                return false;
            }

            
            OleDbConnection oleCon = null;
            DataSet ds = null;
            try
            {
                // خواندن رکوردها از فایل اکسل
                List<Traffics> traffics = new List<Traffics>();
                string StrCon = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source= " + fileName
                                + ";Extended Properties=Excel 8.0;";
                oleCon = new OleDbConnection(StrCon);
                oleCon.Open();
                OleDbDataAdapter da =
                    new OleDbDataAdapter(
                        "select * from [" + sheetName +"]", oleCon);
                ds = new DataSet();
                da.Fill(ds);
                int delrow = 2;
                // ذخیره رکوردها در لیست
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    delrow--;
                    if (delrow <= 0)
                    {
                        Traffics t = new Traffics();
                        t.BarCode = sheetName != null ? sheetName.Remove(sheetName.Length - 2).Remove(0,1) : "";
                        t.Date = row[2] != null ? Converter.ConvertToPersian(row[2].ToString()) : DateTime.MinValue;
                        t.FirstIn = row[3] != null ? Converter.ConvertToMinute(row[3].ToString()) : 9999; // 9999 = null
                        t.LastOut = row[4] != null ? Converter.ConvertToMinute(row[4].ToString()) : 9999; // 9999 = null
                        traffics.Add(t);
                    }
                }
                oleCon.Close();
                // Sort
                //traffics.OrderBy(o => o.BarCode);

                // تمام ترددهای فرد
                DateTime min = traffics.Min(m => m.Date);
                DateTime max= traffics.Max(m=>m.Date);
                IQueryable<AtlasTrafficReader.TA_BaseTraffic> allPersonTraffics = falatGTS.TA_BaseTraffic.Where(w => w.BasicTraffic_PersonID == personId && w.BasicTraffic_Date>=min && w.BasicTraffic_Date<=max);


                foreach (Traffics traffic in traffics)
                {
                    RegisterRecord(traffic, fileName, personId, allPersonTraffics);
                }
                // ثبت در دیتابیس
                using (var logDB = new LogDBEntities())
                {
                    TA_TrafficLog trafficLogSuccess = new TA_TrafficLog();
                    trafficLogSuccess.FileName = fileName;
                    DateTime dateTime = DateTime.Now;
                    trafficLogSuccess.Date = dateTime;
                    trafficLogSuccess.Message = "Success";
                    trafficLogSuccess.Exception = "Successfully Add " + RecordCount + " Record(s) From Sheet " + sheetName + ".";
                    logDB.TA_TrafficLog.AddObject(trafficLogSuccess);
                    logDB.SaveChanges();
                }
                //Info.Message += "Successfully Add " + RecordCount + " Record(s) From Sheet " + sheetName + ".\n";
                

                // Run UpdateCFP Stored Procedure
                if (RecordCount != 0)
                    RunSP(personId, traffics.Min(m => m.Date));

                RecordCount = 0;
            }
            catch (Exception ex)
            {
                LogError("Method: ReadSheet; SheetName: "+sheetName+"; Error: " + ex, fileName);
                //Info.Message += "Method: ReadSheet; SheetName: " + sheetName + "; Error: " + ex.Message + "; FileName: " + fileName + "\n";
                return false;
            }
            finally
            {
                if (oleCon != null)
                {
                    oleCon.Close();
                    oleCon.Dispose();
                }
                if (ds != null)
                {
                    ds.Dispose();
                }
            }
            return true;
        }

        private bool RegisterRecord(Traffics traffic, string fileName, decimal personId, IQueryable<AtlasTrafficReader.TA_BaseTraffic> allPersonTraffics)
        {
            try
            {
                var falatGTS = new FalatGTSEntities();
                // رکورد تکراری
                if (
                    allPersonTraffics.Count(
                        w =>
                        w.BasicTraffic_PersonID == personId && w.BasicTraffic_Date == traffic.Date
                        && (w.BasicTraffic_Time == traffic.FirstIn || w.BasicTraffic_Time == traffic.LastOut)) > 0) return false;

                // ذخیره رکورد
                TA_BaseTraffic baseTrafficFI = null;
                TA_BaseTraffic baseTrafficLO = null;
                if (traffic.FirstIn != 9999) // 9999 = null
                {
                    baseTrafficFI = new TA_BaseTraffic();
                    if (traffic.FirstIn == 0)
                    {
                        baseTrafficFI.BasicTraffic_Time = traffic.FirstIn + 1;
                    }
                    else
                    {
                        baseTrafficFI.BasicTraffic_Time = traffic.FirstIn;
                    }
                    baseTrafficFI.BasicTraffic_Date = traffic.Date;
                    baseTrafficFI.BasicTraffic_PrecardId = 8832;
                    baseTrafficFI.BasicTraffic_PersonID = personId;
                    baseTrafficFI.BasicTraffic_Used = false;
                    baseTrafficFI.BasicTraffic_Active = true;
                    baseTrafficFI.BasicTraffic_Manual = false;
                    baseTrafficFI.BasicTraffic_State = true;
                    baseTrafficFI.BasicTraffic_ReportsListId = 0;
                    baseTrafficFI.BasicTraffic_OperatorPersonID = null;
                    baseTrafficFI.BasicTraffic_Description = null;
                    baseTrafficFI.BasicTraffic_ClockCustomCode = null;
                }
                if (traffic.LastOut != 9999)  // 9999 = null
                {
                    baseTrafficLO = new TA_BaseTraffic();
                    if (traffic.LastOut == 0)
                    {
                        baseTrafficLO.BasicTraffic_Time = traffic.LastOut - 1;
                        baseTrafficLO.BasicTraffic_Date = traffic.Date.Subtract(new TimeSpan(1, 0, 0, 0));
                    }
                    else
                    {
                        baseTrafficLO.BasicTraffic_Time = traffic.LastOut;
                        baseTrafficLO.BasicTraffic_Date = traffic.Date;
                    }
                    baseTrafficLO.BasicTraffic_PrecardId = 8832;
                    baseTrafficLO.BasicTraffic_PersonID = personId;
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
                {
                    falatGTS.TA_BaseTraffic.AddObject(baseTrafficFI);
                    falatGTS.SaveChanges();
                    RecordCount++;
                }
                if (baseTrafficLO != null)
                {
                    falatGTS.TA_BaseTraffic.AddObject(baseTrafficLO);
                    falatGTS.SaveChanges();
                    RecordCount++;
                }

                // اجرای Stored Procedure
                //if (baseTrafficFI != null || baseTrafficLO != null)
                //{
                //    SP proc = new SP();
                //    proc.PersonID = personId;
                //    proc.Date = traffic.Date;
                //    sp.Add(proc);
                //}
                return true;
            }
            catch (Exception ex)
            {
                LogError("Method: RegisterRecord; Barcode: "+traffic.BarCode +"; Error: "+ ex, fileName);
                //Info.Message += "Method: RegisterRecord; Barcode: " + traffic.BarCode + "; Error: " + ex.Message + "; FileName: " + fileName + "\n";
                return false;
            }
        }

        private void LogError(string ex, string fileName)
        {
            try
            {
                var logDB = new LogDBEntities();
                TA_TrafficLog trafficLogError = new TA_TrafficLog();
                trafficLogError.FileName = fileName;
                DateTime dateTime = DateTime.Now;
                trafficLogError.Date = dateTime;
                trafficLogError.Message = "Error";
                trafficLogError.Exception = ex;
                logDB.TA_TrafficLog.AddObject(trafficLogError);
                logDB.SaveChanges();
            }
            catch (Exception exception)
            {
                System.Windows.Forms.MessageBox.Show("Method: LogError; Error: " + exception.Message + "\n", "DATABASE ERROR!", System.Windows.Forms.MessageBoxButtons.OK, System.Windows.Forms.MessageBoxIcon.Error);
                //Info.Message += "DATABASE ERROR! Method: LogError; Error: " + exception.Message + "\n";
            }
        }

        private void RunSP(decimal personId,DateTime date)
        {
            var falatGTS = new FalatGTSEntities();
            falatGTS.UpdateCFP(personId, date);

            //List<decimal> i = new List<decimal>();
            //var ordered = sp.OrderBy(o => o.Date).Select(s => s);
            //var falatGTS = new FalatGTSEntities();
            //foreach (SP person in ordered)
            //{
            //    if (!i.Contains(person.PersonID))
            //    {
            //        falatGTS.UpdateCFP(person.PersonID, person.Date);
            //        i.Add(person.PersonID);
            //    }
            //}
        }
    }
}
