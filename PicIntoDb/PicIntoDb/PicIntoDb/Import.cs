using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Configuration;

namespace PicIntoDb
{
    internal class Import
    {
        private readonly AtlasEntities _atlas = new AtlasEntities();

        private IEnumerable<FileInfo> ReadFiles()
        {
            List<FileInfo> fileInfo = null;
            if (Directory.Exists(ConfigurationManager.AppSettings["FolderPath"]))
            {
                string[] files = Directory.GetFiles(ConfigurationManager.AppSettings["FolderPath"]);
                fileInfo =
                    (files.Select(file => new FileInfo(file)).ToList()).Where(
                        info =>
                        info.Extension.ToLower() == ConfigurationManager.AppSettings["FileFormat"] &&
                        info.Length <= (Convert.ToInt32(ConfigurationManager.AppSettings["FileMaximumSizeKB"])*1024))
                                                                       .ToList();
            }
            return fileInfo;
        }

        public void InsertFiles()
        {
            var files = ReadFiles();

            foreach (var fileInfo in files)
            {
                Inserting(fileInfo);
                AfterInsert(fileInfo);
            }
        }

        private bool Inserting(FileInfo fileInfo)
        {
            try
            {
                var fileBarcode = (Convert.ToInt32(fileInfo.Name.Remove(fileInfo.Name.Length - 4, 4))).ToString();
                //var fileBarcodePad=fileBarcode.PadLeft(8,'0');
                if (_atlas.TA_Person.Count(count => count.Prs_Barcode == fileBarcode)==1)
                {
                    var fileId = (from id in _atlas.TA_Person
                                  where id.Prs_Barcode == fileBarcode
                                  select id.Prs_ID).Single();
                    var personDetail = (from person in _atlas.TA_PersonDetail
                                        where person.PrsDtl_ID == fileId
                                        select person).First();
                    byte[] b = File.ReadAllBytes(fileInfo.FullName);
                    personDetail.PrsDtl_Image = BitConverter.ToString(b).Replace("-", string.Empty);
                    _atlas.SaveChanges();
                }
            }
            catch (Exception ex)
            {
                return false;
            }
            return true;
        }

        private bool AfterInsert(FileInfo fileInfo)
        {
            try
            {
                if (ConfigurationManager.AppSettings["DeleteFile"] == "true")
                {
                    File.Delete(fileInfo.FullName);
                }
            }
            catch (Exception ex)
            {
                return false;
            }
            return true;
        }
    }
}

