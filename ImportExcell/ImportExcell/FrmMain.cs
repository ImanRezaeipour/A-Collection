using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using DevExpress.XtraEditors.Repository;
using ImportExcell.Properties;
using Excel = Microsoft.Office.Interop.Excel;

namespace ImportExcell
{
    public partial class FrmMain : Form
    {

        public FrmMain()
        {
            InitializeComponent();
        }

        private void btnAddUpdate_Click(object sender, EventArgs e)
        {
            //FrmWait wait = new FrmWait();
            //wait.ShowDialog();

            // اتصال به فایل اکسل
            Excel.Application xlApp;
            Excel.Workbook xlWorkBook;
            Excel.Worksheet xlWorkSheet;
            Excel.Range range;
            object misValue = System.Reflection.Missing.Value;
            xlApp = new Excel.Application();
            xlWorkBook = xlApp.Workbooks.Open(txtBrowse.Text, 0, true, 5, "", "", true, Microsoft.Office.Interop.Excel.XlPlatform.xlWindows, "\t", false, false, 0, true, 1, 0);
            xlWorkSheet = (Excel.Worksheet)xlWorkBook.Worksheets.get_Item(1);
            range = xlWorkSheet.UsedRange;

            // ساخت دیتابیس مجازی
            DataTable dt = new DataTable();
            dt.Columns.Add("ID");
            dt.Columns.Add("Barcode");
            dt.Columns.Add("Param");
            dt.Columns.Add("Active");
            dt.Columns.Add("CardNumber");
            dt.Columns.Add("DepartmentCode");
            dt.Columns.Add("EmploymentNumber");
            dt.Columns.Add("EmploymentDate");
            dt.Columns.Add("EndEmploymentDate");
            dt.Columns.Add("EmploymentCode");
            dt.Columns.Add("Sex");
            dt.Columns.Add("Education");
            dt.Columns.Add("FirstName");
            dt.Columns.Add("MaritalStatus");
            dt.Columns.Add("LastName");
            dt.Columns.Add("DetailID");
            dt.Columns.Add("Deleted");
            dt.Columns.Add("CreationDate");
            dt.Columns.Add("GradeCode");
            dt.Columns.Add("DigitalSignature");

            dt.Columns.Add("ID_new");
            dt.Columns.Add("Barcode_new");
            dt.Columns.Add("Param_new");
            dt.Columns.Add("Active_new");
            dt.Columns.Add("CardNumber_new");
            dt.Columns.Add("DepartmentCode_new");
            dt.Columns.Add("EmploymentNumber_new");
            dt.Columns.Add("EmploymentDate_new");
            dt.Columns.Add("EndEmploymentDate_new");
            dt.Columns.Add("EmploymentCode_new");
            dt.Columns.Add("Sex_new");
            dt.Columns.Add("Education_new");
            dt.Columns.Add("FirstName_new");
            dt.Columns.Add("MaritalStatus_new");
            dt.Columns.Add("LastName_new");
            dt.Columns.Add("DetailID_new");
            dt.Columns.Add("Deleted_new");
            dt.Columns.Add("CreationDate_new");
            dt.Columns.Add("GradeCode_new");
            dt.Columns.Add("DigitalSignature_new");

            for (int a = 2; a < 1000; a++)
            {
                // check barcode value is correct
                try { int barcode = Convert.ToInt32((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbBarcode.SelectedItem).Value)] as Excel.Range).Value2); }
                catch (Exception ex) { continue; }

                var row = dt.NewRow();

                if (cmbBarcode.SelectedItem != null)
                    row["Barcode"] = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbBarcode.SelectedItem).Value)] as Excel.Range).Value2);
                else // default value
                    row["Barcode"] = "00000000";

                //if (cmbAddress.SelectedItem != null)
                //    row["Param"] = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbAddress.SelectedItem).Value)] as Excel.Range).Value2);
                //else // default value
                    row["Param"] = 0;

                //if (cmbAddress.SelectedItem != null)
                //    row["Active"] = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbAddress.SelectedItem).Value)] as Excel.Range).Value2);
                //else // default value
                    row["Active"] = true;

                if (cmbCardNum.SelectedItem != null)
                    row["CardNumber"] = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbCardNum.SelectedItem).Value)] as Excel.Range).Value2);
                else // default value
                    row["CardNumber"] = "00000000";

                if (cmbDepartment.SelectedItem != null)
                    row["DepartmentCode"] = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbDepartment.SelectedItem).Value)] as Excel.Range).Value2);
                else // default value
                    row["DepartmentCode"] = 1111111;

                if (cmbEmployeNum.SelectedItem != null)
                    row["EmploymentNumber"] = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbEmployeNum.SelectedItem).Value)] as Excel.Range).Value2);
                else // default value
                    row["EmploymentNumber"] = "00000000";

                if (cmbEmployeDateBegin.SelectedItem != null)
                    row["EmploymentDate"] = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbEmployeDateBegin.SelectedItem).Value)] as Excel.Range).Value2);
                else // default value
                    row["EmploymentDate"] = "2000/03/20";

                if (cmbEmployeDateEnd.SelectedItem != null)
                    row["EndEmploymentDate"] = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbEmployeDateEnd.SelectedItem).Value)] as Excel.Range).Value2);
                else // default value
                    row["EndEmploymentDate"] = "2050/03/20";

                if (cmbEmploye.SelectedItem != null)
                    row["EmploymentCode"] = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbEmploye.SelectedItem).Value)] as Excel.Range).Value2);
                else // default value
                    row["EmploymentCode"] = 1111111;

                if (cmbSex.SelectedItem != null)
                    row["Sex"] = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbSex.SelectedItem).Value)] as Excel.Range).Value2);
                else // default value
                    row["Sex"] = false;

                if (cmbEducation.SelectedItem != null)
                    row["Education"] = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbEducation.SelectedItem).Value)] as Excel.Range).Value2);
                else // default value
                    row["Education"] = "";

                if (cmbFirstName.SelectedItem != null)
                    row["FirstName"] = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbFirstName.SelectedItem).Value)] as Excel.Range).Value2);
                else // default value
                    row["FirstName"] = "";

                if (cmbMarital.SelectedItem != null)
                    row["MaritalStatus"] = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbMarital.SelectedItem).Value)] as Excel.Range).Value2);
                else // default value
                    row["MaritalStatus"] = 0;

                if (cmbLastName.SelectedItem != null)
                    row["LastName"] = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbLastName.SelectedItem).Value)] as Excel.Range).Value2);
                else // default value
                    row["LastName"] = "";

                if (cmbDeleted.SelectedItem != null)
                    row["Deleted"] = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbDeleted.SelectedItem).Value)] as Excel.Range).Value2);
                else // default value
                    row["Deleted"] = false;

                //if (cmbAddress.SelectedItem != null)
                //    row["CreationDate"] = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbAddress.SelectedItem).Value)] as Excel.Range).Value2);
                //else // default value
                    row["CreationDate"] = DateTime.Now;

                if (cmbGrade.SelectedItem != null)
                    row["GradeCode"] = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbGrade.SelectedItem).Value)] as Excel.Range).Value2);
                else // default value
                    row["GradeCode"] = 1111132;

                //if (cmbAddress.SelectedItem != null)
                //    row["DigitalSignature"] = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbAddress.SelectedItem).Value)] as Excel.Range).Value2);
                //else // default value
                    row["DigitalSignature"] = "";

                dt.Rows.Add(row);
            }

            using (var model = new AtlasEntities())
            {
                var personNew = new TA_Person();
                var personUpdate=new TA_Person();


                    // اجرا برای هر سطر فایل اکسل
                    for (int a = 1; a < dt.Rows.Count; a++)
                    {
                        string barcode;
                        if (dt.Rows[a]["Barcode_new"].ToString() == "")
                            barcode = Convert.ToString(dt.Rows[a]["Barcode"]);
                        else
                            barcode = Convert.ToString(dt.Rows[a]["Barcode_new"]);
                        personUpdate = model.TA_Person.FirstOrDefault(x => x.Prs_Barcode == barcode);

                    if (personUpdate == null)
                    {

                        if (dt.Rows[a]["Barcode_new"].ToString() == "")
                            personNew.Prs_Barcode = Convert.ToString(dt.Rows[a]["Barcode"]);
                        else
                            personNew.Prs_Barcode = Convert.ToString(dt.Rows[a]["Barcode_new"]);

                        if (dt.Rows[a]["Param_new"].ToString() == "")
                            personNew.Prs__Param = Convert.ToInt32(dt.Rows[a]["Param"]);
                        else
                            personNew.Prs__Param = Convert.ToInt32(dt.Rows[a]["Param_new"]);

                        if (dt.Rows[a]["Active_new"].ToString() == "")
                            personNew.Prs_Active = Convert.ToBoolean(dt.Rows[a]["Active"]);
                        else
                            personNew.Prs_Active = Convert.ToBoolean(dt.Rows[a]["Active_new"]);

                        if (dt.Rows[a]["CardNumber_new"].ToString() == "")
                            personNew.Prs_CardNum = Convert.ToString(dt.Rows[a]["CardNumber"]);
                        else
                            personNew.Prs_CardNum = Convert.ToString(dt.Rows[a]["CardNumber_new"]);

                        if (dt.Rows[a]["DepartmentCode_new"].ToString() == "")
                            personNew.Prs_DepartmentId = Convert.ToInt32(dt.Rows[a]["DepartmentCode"]);
                        else
                            personNew.Prs_DepartmentId = Convert.ToInt32(dt.Rows[a]["DepartmentCode_new"]);

                        if (dt.Rows[a]["EmploymentNumber_new"].ToString() == "")
                            personNew.Prs_EmploymentNum = Convert.ToString(dt.Rows[a]["EmploymentNumber"]);
                        else
                            personNew.Prs_EmploymentNum = Convert.ToString(dt.Rows[a]["EmploymentNumber_new"]);

                        if (dt.Rows[a]["EmploymentDate_new"].ToString() == "")
                            personNew.Prs_EmploymentDate = Convert.ToDateTime(dt.Rows[a]["EmploymentDate"]);
                        else
                            personNew.Prs_EmploymentDate = Convert.ToDateTime(dt.Rows[a]["EmploymentDate_new"]);

                        if (dt.Rows[a]["EndEmploymentDate_new"].ToString() == "")
                            personNew.Prs_EndEmploymentDate = Convert.ToDateTime(dt.Rows[a]["EndEmploymentDate"]);
                        else
                            personNew.Prs_EndEmploymentDate = Convert.ToDateTime(dt.Rows[a]["EndEmploymentDate_new"]);

                        if (dt.Rows[a]["EmploymentCode_new"].ToString() == "")
                            personNew.Prs_EmployId = Convert.ToInt32(dt.Rows[a]["EmploymentCode"]);
                        else
                            personNew.Prs_EmployId = Convert.ToInt32(dt.Rows[a]["EmploymentCode_new"]);

                        if (dt.Rows[a]["Sex_new"].ToString() == "")
                            personNew.Prs_Sex = Convert.ToBoolean(dt.Rows[a]["Sex"]);
                        else
                            personNew.Prs_Sex = Convert.ToBoolean(dt.Rows[a]["Sex_new"]);

                        if (dt.Rows[a]["Education_new"].ToString() == "")
                            personNew.Prs_Education = Convert.ToString(dt.Rows[a]["Education"]);
                        else
                            personNew.Prs_Education = Convert.ToString(dt.Rows[a]["Education_new"]);

                        if (dt.Rows[a]["FirstName_new"].ToString() == "")
                            personNew.Prs_FirstName = Convert.ToString(dt.Rows[a]["FirstName"]);
                        else
                            personNew.Prs_FirstName = Convert.ToString(dt.Rows[a]["FirstName_new"]);

                        if (dt.Rows[a]["MaritalStatus_new"].ToString() == "")
                            personNew.Prs_MaritalStatus = Convert.ToInt32(dt.Rows[a]["MaritalStatus"]);
                        else
                            personNew.Prs_MaritalStatus = Convert.ToInt32(dt.Rows[a]["MaritalStatus_new"]);

                        if (dt.Rows[a]["LastName_new"].ToString() == "")
                            personNew.Prs_LastName = Convert.ToString(dt.Rows[a]["LastName"]);
                        else
                            personNew.Prs_LastName = Convert.ToString(dt.Rows[a]["LastName_new"]);

                        if (dt.Rows[a]["Deleted_new"].ToString() == "")
                            personNew.prs_IsDeleted = Convert.ToBoolean(dt.Rows[a]["Deleted"]);
                        else
                            personNew.prs_IsDeleted = Convert.ToBoolean(dt.Rows[a]["Deleted_new"]);

                        if (dt.Rows[a]["CreationDate_new"].ToString() == "")
                            personNew.prs_CreationDate = Convert.ToDateTime(dt.Rows[a]["CreationDate"]);
                        else
                            personNew.prs_CreationDate = Convert.ToDateTime(dt.Rows[a]["CreationDate_new"]);

                        if (dt.Rows[a]["GradeCode_new"].ToString() == "")
                            personNew.prs_GradeId = Convert.ToInt32(dt.Rows[a]["GradeCode"]);
                        else
                            personNew.prs_GradeId = Convert.ToInt32(dt.Rows[a]["GradeCode_new"]);

                        if (dt.Rows[a]["DigitalSignature_new"].ToString() == "")
                            personNew.Prs_DigitalSignature = Convert.ToString(dt.Rows[a]["DigitalSignature"]);
                        else
                            personNew.Prs_DigitalSignature = Convert.ToString(dt.Rows[a]["DigitalSignature_new"]);

                        model.TA_Person.Add(personNew);
                        model.SaveChanges();
                    }

                    else // Person Updated
                    {
                        if (dt.Rows[a]["Barcode_new"].ToString() == "")
                            personUpdate.Prs_Barcode = Convert.ToString(dt.Rows[a]["Barcode"]);
                        else
                            personUpdate.Prs_Barcode = Convert.ToString(dt.Rows[a]["Barcode_new"]);

                        if (dt.Rows[a]["Param_new"].ToString() == "")
                            personUpdate.Prs__Param = Convert.ToInt32(dt.Rows[a]["Param"]);
                        else
                            personUpdate.Prs__Param = Convert.ToInt32(dt.Rows[a]["Param_new"]);

                        if (dt.Rows[a]["Active_new"].ToString() == "")
                            personUpdate.Prs_Active = Convert.ToBoolean(dt.Rows[a]["Active"]);
                        else
                            personUpdate.Prs_Active = Convert.ToBoolean(dt.Rows[a]["Active_new"]);

                        if (dt.Rows[a]["CardNumber_new"].ToString() == "")
                            personUpdate.Prs_CardNum = Convert.ToString(dt.Rows[a]["CardNumber"]);
                        else
                            personUpdate.Prs_CardNum = Convert.ToString(dt.Rows[a]["CardNumber_new"]);

                        if (dt.Rows[a]["DepartmentCode_new"].ToString() == "")
                            personUpdate.Prs_DepartmentId = Convert.ToInt32(dt.Rows[a]["DepartmentCode"]);
                        else
                            personUpdate.Prs_DepartmentId = Convert.ToInt32(dt.Rows[a]["DepartmentCode_new"]);

                        if (dt.Rows[a]["EmploymentNumber_new"].ToString() == "")
                            personUpdate.Prs_EmploymentNum = Convert.ToString(dt.Rows[a]["EmploymentNumber"]);
                        else
                            personUpdate.Prs_EmploymentNum = Convert.ToString(dt.Rows[a]["EmploymentNumber_new"]);

                        if (dt.Rows[a]["EmploymentDate_new"].ToString() == "")
                            personUpdate.Prs_EmploymentDate = Convert.ToDateTime(dt.Rows[a]["EmploymentDate"]);
                        else
                            personUpdate.Prs_EmploymentDate = Convert.ToDateTime(dt.Rows[a]["EmploymentDate_new"]);

                        if (dt.Rows[a]["EndEmploymentDate_new"].ToString() == "")
                            personUpdate.Prs_EndEmploymentDate = Convert.ToDateTime(dt.Rows[a]["EndEmploymentDate"]);
                        else
                            personUpdate.Prs_EndEmploymentDate = Convert.ToDateTime(dt.Rows[a]["EndEmploymentDate_new"]);

                        if (dt.Rows[a]["EmploymentCode_new"].ToString() == "")
                            personUpdate.Prs_EmployId = Convert.ToInt32(dt.Rows[a]["EmploymentCode"]);
                        else
                            personUpdate.Prs_EmployId = Convert.ToInt32(dt.Rows[a]["EmploymentCode_new"]);

                        if (dt.Rows[a]["Sex_new"].ToString() == "")
                            personUpdate.Prs_Sex = Convert.ToBoolean(dt.Rows[a]["Sex"]);
                        else
                            personUpdate.Prs_Sex = Convert.ToBoolean(dt.Rows[a]["Sex_new"]);

                        if (dt.Rows[a]["Education_new"].ToString() == "")
                            personUpdate.Prs_Education = Convert.ToString(dt.Rows[a]["Education"]);
                        else
                            personUpdate.Prs_Education = Convert.ToString(dt.Rows[a]["Education_new"]);

                        if (dt.Rows[a]["FirstName_new"].ToString() == "")
                            personUpdate.Prs_FirstName = Convert.ToString(dt.Rows[a]["FirstName"]);
                        else
                            personUpdate.Prs_FirstName = Convert.ToString(dt.Rows[a]["FirstName_new"]);

                        if (dt.Rows[a]["MaritalStatus_new"].ToString() == "")
                            personUpdate.Prs_MaritalStatus = Convert.ToInt32(dt.Rows[a]["MaritalStatus"]);
                        else
                            personUpdate.Prs_MaritalStatus = Convert.ToInt32(dt.Rows[a]["MaritalStatus_new"]);

                        if (dt.Rows[a]["LastName_new"].ToString() == "")
                            personUpdate.Prs_LastName = Convert.ToString(dt.Rows[a]["LastName"]);
                        else
                            personUpdate.Prs_LastName = Convert.ToString(dt.Rows[a]["LastName_new"]);

                        if (dt.Rows[a]["Deleted_new"].ToString() == "")
                            personUpdate.prs_IsDeleted = Convert.ToBoolean(dt.Rows[a]["Deleted"]);
                        else
                            personUpdate.prs_IsDeleted = Convert.ToBoolean(dt.Rows[a]["Deleted_new"]);

                        if (dt.Rows[a]["CreationDate_new"].ToString() == "")
                            personUpdate.prs_CreationDate = Convert.ToDateTime(dt.Rows[a]["CreationDate"]);
                        else
                            personUpdate.prs_CreationDate = Convert.ToDateTime(dt.Rows[a]["CreationDate_new"]);

                        if (dt.Rows[a]["GradeCode_new"].ToString() == "")
                            personUpdate.prs_GradeId = Convert.ToInt32(dt.Rows[a]["GradeCode"]);
                        else
                            personUpdate.prs_GradeId = Convert.ToInt32(dt.Rows[a]["GradeCode_new"]);

                        if (dt.Rows[a]["DigitalSignature_new"].ToString() == "")
                            personUpdate.Prs_DigitalSignature = Convert.ToString(dt.Rows[a]["DigitalSignature"]);
                        else
                            personUpdate.Prs_DigitalSignature = Convert.ToString(dt.Rows[a]["DigitalSignature_new"]);

                        model.SaveChanges();
                    }
                }

                
            }

                    //        // چک کردن انتخاب فیلد بارکد
                    //        if (cmbBarcode.SelectedItem == null)
                    //        {
                    //            errorRequire.SetError(cmbBarcode, "کد پرسنلی اجباری است");
                    //            break;
                    //        }



                    //        string barcode = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbBarcode.SelectedItem).Value)] as Excel.Range).Value2);
                    //        var personUpdate = model.TA_Person.FirstOrDefault(x => x.Prs_Barcode == barcode);

                    //        if (personUpdate == null) // Add
                    //        {
                    //            // موارد مور چک
                    //            // اگر انتخاب شده باشند و اگر نشدند مقدار پیش فرض 
                    //            // تبدیل نوع برای داده های دیگر
                    //            // رد شدن از خطاها


                    //            // Person Detail
                    //            var personDetail = new TA_PersonDetail();

                    //            if (cmbAddress.SelectedItem != null)
                    //                try { personDetail.PrsDtl_Address = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbAddress.SelectedItem).Value)] as Excel.Range).Value2); }
                    //                catch (Exception ex) { }

                    //            //if (((ComboboxItem)cmbAddress.SelectedItem).Value != null)
                    //            //personDetail.PrsDtl_BirthCertificate = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbFatherName.SelectedItem).Value)] as Excel.Range).Value2);

                    //            if (cmbBirthDate.SelectedItem != null)
                    //                try { personDetail.PrsDtl_BirthDate = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbBirthDate.SelectedItem).Value)] as Excel.Range).Value2); }
                    //                catch (Exception ex) { }

                    //            if (cmbBirthPlace.SelectedItem != null)
                    //                try { personDetail.PrsDtl_BirthPlace = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbBirthPlace.SelectedItem).Value)] as Excel.Range).Value2); }
                    //                catch (Exception ex) { }

                    //            if (cmbMail.SelectedItem != null)
                    //                try { personDetail.PrsDtl_EmailAddress = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbMail.SelectedItem).Value)] as Excel.Range).Value2); }
                    //                catch (Exception ex) { }

                    //            if (cmbFatherName.SelectedItem != null)
                    //                try { personDetail.PrsDtl_FatherName = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbFatherName.SelectedItem).Value)] as Excel.Range).Value2); }
                    //                catch (Exception ex) { }

                    //            //if (((ComboboxItem)cmbAddress.SelectedItem).Value != null)
                    //            //personDetail.PrsDtl_Grade = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbFatherName.SelectedItem).Value)] as Excel.Range).Value2);

                    //            if (cmbBarcode.SelectedItem != null)
                    //                try { personDetail.PrsDtl_Image = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbBarcode.SelectedItem).Value)] as Excel.Range).Value2) + ".jpg"; }
                    //                catch (Exception ex) { }

                    //            if (cmbMeliCode.SelectedItem != null)
                    //                try { personDetail.PrsDtl_MeliCode = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbMeliCode.SelectedItem).Value)] as Excel.Range).Value2); }
                    //                catch (Exception ex) { }

                    //            if (cmbMilitary.SelectedItem != null)
                    //                try { personDetail.PrsDtl_MilitaryStatus = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbMilitary.SelectedItem).Value)] as Excel.Range).Value2); }
                    //                catch (Exception ex) { }

                    //            if (cmbMobile.SelectedItem != null)
                    //                try { personDetail.PrsDtl_MobileNumber = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbMobile.SelectedItem).Value)] as Excel.Range).Value2); }
                    //                catch (Exception ex) { }

                    //            if (cmbPlaceIssued.SelectedItem != null)
                    //                try { personDetail.PrsDtl_PlaceIssued = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbPlaceIssued.SelectedItem).Value)] as Excel.Range).Value2); }
                    //                catch (Exception ex) { }

                    //            if (cmbShenasname.SelectedItem != null)
                    //                try { personDetail.PrsDtl_ShomareShenasname = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbShenasname.SelectedItem).Value)] as Excel.Range).Value2); }
                    //                catch (Exception ex) { }

                    //            //if (cmbStatus.SelectedItem != null)
                    //                //try { personDetail.PrsDtl_Status = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbStatus.SelectedItem).Value)] as Excel.Range).Value2); }
                    //                //catch (Exception ex) { }

                    //            if (cmbTel.SelectedItem != null)
                    //                try { personDetail.PrsDtl_Tel = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbTel.SelectedItem).Value)] as Excel.Range).Value2); }
                    //                catch (Exception ex) { }

                    //            model.TA_PersonDetail.Add(personDetail);
                    //            model.SaveChanges();

                    //            // Person
                    //            personNew.Prs__Param = null;

                    //            if (cmbPersonActive.SelectedItem != null)
                    //                try { personNew.Prs_Active = Convert.ToBoolean((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbPersonActive.SelectedItem).Value)] as Excel.Range).Value2); }
                    //                catch (Exception ex) { }

                    //            if (cmbBarcode.SelectedItem != null)
                    //                try { personNew.Prs_Barcode = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbBarcode.SelectedItem).Value)] as Excel.Range).Value2); }
                    //                catch (Exception ex) { }

                    //            if (cmbCardNum.SelectedItem != null)
                    //                try { personNew.Prs_CardNum = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbCardNum.SelectedItem).Value)] as Excel.Range).Value2); }
                    //                catch (Exception ex) { }

                    //            try { personNew.prs_CreationDate = DateTime.Now; }
                    //            catch (Exception ex) { }

                    //            if (cmbDepartment.SelectedItem != null)
                    //            {
                    //                try
                    //                {
                    //                    string department = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbDepartment.SelectedItem).Value)] as Excel.Range).Value2);
                    //                    personNew.Prs_DepartmentId = model.TA_Department.FirstOrDefault(x => x.dep_CustomCode == department).dep_ID;
                    //                }
                    //                catch (Exception ex) { }
                    //            }

                    //            if (cmbEducation.SelectedItem != null)
                    //                try { personNew.Prs_Education = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbEducation.SelectedItem).Value)] as Excel.Range).Value2); }
                    //                catch (Exception ex) { }

                    //            //if (((ComboboxItem)cmbMeliCode.SelectedItem).Value != null)     
                    //            //personNew.Prs_EmployId = ;

                    //            if (cmbEmployeDateBegin.SelectedItem != null)
                    //                try { personNew.Prs_EmploymentDate = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbEmployeDateBegin.SelectedItem).Value)] as Excel.Range).Value2); }
                    //                catch (Exception ex) { }

                    //            if (cmbEmployeNum.SelectedItem != null)
                    //                try { personNew.Prs_EmploymentNum = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbEmployeNum.SelectedItem).Value)] as Excel.Range).Value2); }
                    //                catch (Exception ex) { }

                    //            if (cmbEmployeDateEnd.SelectedItem != null)
                    //                try { personNew.Prs_EndEmploymentDate = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbEmployeDateEnd.SelectedItem).Value)] as Excel.Range).Value2); }
                    //                catch (Exception ex) { }

                    //            if (cmbFirstName.SelectedItem != null)
                    //                try { personNew.Prs_FirstName = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbFirstName.SelectedItem).Value)] as Excel.Range).Value2); }
                    //                catch (Exception ex) { }

                    //            //if (((ComboboxItem)cmbMeliCode.SelectedItem).Value != null)  
                    //            //personNew.prs_GradeId = ;

                    //            if (cmbDeleted.SelectedItem != null)  
                    //            try{personNew.prs_IsDeleted = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbDeleted.SelectedItem).Value)] as Excel.Range).Value2); }
                    //            catch (Exception ex) { }

                    //            if (cmbLastName.SelectedItem != null)
                    //                try { personNew.Prs_LastName = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbLastName.SelectedItem).Value)] as Excel.Range).Value2); }
                    //                catch (Exception ex) { }

                    //            if (cmbMarital.SelectedItem != null)
                    //                try { personNew.Prs_MaritalStatus = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbMarital.SelectedItem).Value)] as Excel.Range).Value2); }
                    //                catch (Exception ex) { }

                    //            try { personNew.Prs_PrsDtlID = personDetail.PrsDtl_ID; }
                    //            catch (Exception ex) { }

                    //            if (cmbSex.SelectedItem != null)
                    //                try { personNew.Prs_Sex = Convert.ToBoolean((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbSex.SelectedItem).Value)] as Excel.Range).Value2); }
                    //                catch (Exception ex) { }

                    //            model.TA_Person.Add(personNew);
                    //            model.SaveChanges();

                    //            // Security User

                    //            // Rule Assign

                    //            // Workgroup

                    //            // Calculation Range

                    //            // Settings

                    //        }
                    //        else // Update
                    //        {
                    //            //personUpdate.Prs_FirstName = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbFirstName.SelectedItem).Value)] as Excel.Range).Value2);
                    //            //person2.TA_PersonDetail.PrsDtl_FatherName = Convert.ToString((range.Cells[a, Convert.ToInt32(((ComboboxItem)cmbFatherName.SelectedItem).Value)] as Excel.Range).Value2);
                    //            model.SaveChanges();
                    //        }
                    //    }
                    //}

            xlWorkBook.Close(true, misValue, misValue);
            xlApp.Quit();
            releaseObject(xlWorkSheet);
            releaseObject(xlWorkBook);
            releaseObject(xlApp);
        }

        private void releaseObject(object obj)
        {
            try
            {
                System.Runtime.InteropServices.Marshal.ReleaseComObject(obj);
                obj = null;
            }
            catch (Exception ex)
            {
                obj = null;
                MessageBox.Show(Resources.FrmMain_releaseObject_Unable_to_release_the_Object_ + ex.ToString());
            }
            finally
            {
                GC.Collect();
            }
        }

        private void btnBrowse_Click(object sender, EventArgs e)
        {
            if (dlgBrowse.ShowDialog() != DialogResult.OK) return;
            txtBrowse.Text = dlgBrowse.FileName;

            object misValue = System.Reflection.Missing.Value;
            var xlApp = new Excel.Application();
            var xlWorkBook = xlApp.Workbooks.Open(txtBrowse.Text, 0, true, 5, "", "", true, Excel.XlPlatform.xlWindows, "\t", false, false, 0, true, 1, 0);
            var xlWorkSheet = (Excel.Worksheet)xlWorkBook.Worksheets.Item[1];
            var range = xlWorkSheet.UsedRange;

            var cmb = new RepositoryItemComboBox();

            for (var a = 1; a < 100; a++)
            {
                var range2 = range.Cells[1, a] as Excel.Range;
                if (range2 != null && ((string)range2.Value2) == null)
                    break;
                // cmbAddress.Items.Add(new ComboboxItem((string)(range.Cells[1, a] as Excel.Range).Value2, a));
                // cmbBarcode.Items.Add(new ComboboxItem((string)(range.Cells[1, a] as Excel.Range).Value2, a));
                // cmbBirthDate.Items.Add(new ComboboxItem((string)(range.Cells[1, a] as Excel.Range).Value2, a));
                // cmbBirthPlace.Items.Add(new ComboboxItem((string)(range.Cells[1, a] as Excel.Range).Value2, a));
                // cmbCardNum.Items.Add(new ComboboxItem((string)(range.Cells[1, a] as Excel.Range).Value2, a));
                // cmbDeleted.Items.Add(new ComboboxItem((string)(range.Cells[1, a] as Excel.Range).Value2, a));
                // cmbDepartment.Items.Add(new ComboboxItem((string)(range.Cells[1, a] as Excel.Range).Value2, a));
                // cmbEducation.Items.Add(new ComboboxItem((string)(range.Cells[1, a] as Excel.Range).Value2, a));
                // cmbEmploye.Items.Add(new ComboboxItem((string)(range.Cells[1, a] as Excel.Range).Value2, a));
                // cmbEmployeDateBegin.Items.Add(new ComboboxItem((string)(range.Cells[1, a] as Excel.Range).Value2, a));
                // cmbEmployeDateEnd.Items.Add(new ComboboxItem((string)(range.Cells[1, a] as Excel.Range).Value2, a));
                // cmbEmployeNum.Items.Add(new ComboboxItem((string)(range.Cells[1, a] as Excel.Range).Value2, a));
                // cmbFatherName.Items.Add(new ComboboxItem((string)(range.Cells[1, a] as Excel.Range).Value2, a));
                // cmbFirstName.Items.Add(new ComboboxItem((string)(range.Cells[1, a] as Excel.Range).Value2, a));
                // cmbGrade.Items.Add(new ComboboxItem((string)(range.Cells[1, a] as Excel.Range).Value2, a));
                // cmbLastName.Items.Add(new ComboboxItem((string)(range.Cells[1, a] as Excel.Range).Value2, a));
                // cmbMail.Items.Add(new ComboboxItem((string)(range.Cells[1, a] as Excel.Range).Value2, a));
                // cmbMeliCode.Items.Add(new ComboboxItem((string)(range.Cells[1, a] as Excel.Range).Value2, a));
                // cmbMilitary.Items.Add(new ComboboxItem((string)(range.Cells[1, a] as Excel.Range).Value2, a));
                // cmbMobile.Items.Add(new ComboboxItem((string)(range.Cells[1, a] as Excel.Range).Value2, a));
                // cmbPersonActive.Items.Add(new ComboboxItem((string)(range.Cells[1, a] as Excel.Range).Value2, a));
                // cmbPlaceIssued.Items.Add(new ComboboxItem((string)(range.Cells[1, a] as Excel.Range).Value2, a));
                // cmbSex.Items.Add(new ComboboxItem((string)(range.Cells[1, a] as Excel.Range).Value2, a));
                // cmbShenasname.Items.Add(new ComboboxItem((string)(range.Cells[1, a] as Excel.Range).Value2, a));
                // cmbMarital.Items.Add(new ComboboxItem((string)(range.Cells[1, a] as Excel.Range).Value2, a));
                // cmbTel.Items.Add(new ComboboxItem((string)(range.Cells[1, a] as Excel.Range).Value2, a));

                var range1 = range.Cells[1, a] as Excel.Range;
                if (range1 != null)
                    ExcelDataTable.dtExcel.Columns.Add(new DataColumn(
                        (string) range1.Value2));
            }


            cmb.Items.AddRange(ExcelDataTable.dtExcel.Columns);

            vGridControl1.Rows["row"].Properties.RowEdit = cmb;
            vGridControl1.Rows["row1"].Properties.RowEdit = cmb;

            xlWorkBook.Close(true, misValue, misValue);
            xlApp.Quit();
            releaseObject(xlWorkSheet);
            releaseObject(xlWorkBook);
            releaseObject(xlApp);

            btnAddUpdate.Enabled = true;
        }

    }
}
