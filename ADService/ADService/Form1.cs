using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.DirectoryServices;
using System.DirectoryServices.AccountManagement;

namespace ADService
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            using (PrincipalContext pc = new PrincipalContext(ContextType.Domain, "tb"))
            {
                
                // validate the credentials
                if (
                pc.ValidateCredentials("p0034-ghadir", "P@ssw0rd12345")
                    )
                    MessageBox.Show("Y");

            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            var atlas = new AtlasEntities();

            using (var context = new PrincipalContext(ContextType.Domain, "tb", "p0034-ghadir", "P@ssw0rd12345"))
            {
                using (var searcher = new PrincipalSearcher(new UserPrincipal(context)))
                {
                    foreach (var result in searcher.FindAll())
                    {
                        DirectoryEntry de = result.GetUnderlyingObject() as DirectoryEntry;
                        var name = de.Properties["samAccountName"].Value.ToString();
                        try
                        {
                            TA_SecurityUser index = atlas.TA_SecurityUser.Where(
                                w => w.user_UserName ==
                                name.Substring(
                                name.Length - 4, 4)).Single();
                            index.user_DomainID = 3;
                            index.user_IsADAuthenticateActive = true;
                            index.user_UserName = name;
                            atlas.SaveChanges();
                        }
                        catch(Exception ex){
                        }
                    }
                }
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            var atlas = new AtlasEntities();

            var personList = atlas.TA_Person.Select(s => s.Prs_ID).ToList();
            List<decimal> pList = new List<decimal>();
            foreach (decimal p in personList)
            {
                if (p != null)
                    pList.Add(p);
            }

            var userList = atlas.TA_SecurityUser.Select(s => s.user_PersonID).ToList();
            List<decimal> uList = new List<decimal>();
            foreach (decimal u in userList)
            {
                if (u != null)
                    uList.Add(u);
            }

            var notUser = pList.Except(uList);
            foreach (decimal not in notUser)
            {
                TA_SecurityUser suser = new TA_SecurityUser();
                suser.user_Active = true;
                suser.user_DomainID = null;
                suser.user_IsADAuthenticateActive = false;
                suser.user_LastActivityDate = null;
                suser.user_Password = "byJxM3esapyy7kd5W/Hcdom3XfNC";//"user123"
                suser.user_PersonID = not;
                suser.user_RoleID = 20;
                suser.user_UserName = atlas.TA_Person.Where(w=>w.Prs_ID==not).Select(s=>s.Prs_Barcode).SingleOrDefault();
                atlas.TA_SecurityUser.Add(suser);
                atlas.SaveChanges();
            }

        }


        




    }
}
