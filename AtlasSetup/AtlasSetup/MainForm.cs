using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;
using System.Threading.Tasks;
using Amib.Threading;
using System.DirectoryServices;
namespace AtlasSetup
{
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
        }

        private void btnBrowse_Click(object sender, EventArgs e)
        {
            if(folderInstall.ShowDialog()==DialogResult.OK){
                txtInstallFolder.Text = folderInstall.SelectedPath;
            }
        }

        private void btnInstallAtlas_Click(object sender, EventArgs e)
        {
            //time.Start();
            treeCopyDetail.Nodes.Add(txtInstallFolder.Text + @"\");
            treeCopyDetail.Nodes[0].Nodes.Add("");
            Copy copy = new Copy();

            SmartThreadPool smartThreadPool = new SmartThreadPool();
            smartThreadPool.QueueWorkItem(copy.DirectoryCopy, @".\Atlas\", txtInstallFolder.Text + @"\", true);
            smartThreadPool.Start();
        }


        private void time_Tick(object sender, EventArgs e)
        {
            
            //rtbCopyDetail.Text=Copy.Detail;
            ListDirectory(treeCopyDetail, txtInstallFolder.Text + @"\");
        }

        private static void ListDirectory(TreeView treeView, string path)
        {
            //treeView.Nodes.Clear();

            var stack = new Stack<TreeNode>();
            var rootDirectory = new DirectoryInfo(path);
            var node = new TreeNode(rootDirectory.Name) { Tag = rootDirectory };
            stack.Push(node);

            while (stack.Count > 0)
            {
                var currentNode = stack.Pop();
                var directoryInfo = (DirectoryInfo)currentNode.Tag;
                foreach (var directory in directoryInfo.GetDirectories())
                {
                    var childDirectoryNode = new TreeNode(directory.Name) { Tag = directory };
                    if (!currentNode.Nodes.Contains(childDirectoryNode))
                    {
                        currentNode.Nodes.Add(childDirectoryNode);
                        stack.Push(childDirectoryNode);
                    }
                }
                foreach (var file in directoryInfo.GetFiles())
                    if (!currentNode.Nodes.Contains(new TreeNode(file.Name)))
                        currentNode.Nodes.Add(new TreeNode(file.Name));
            }

            
                treeView.Nodes.Add(node);
        }

        private void btnWinrar_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process.Start(@".\Programms\Winrar\Setup.exe");
        }

        private void btnELE_Click(object sender, EventArgs e)
        {
            
            var result=System.Diagnostics.Process.Start(@"C:\Users\Iman\Documents\AtlasSetup\AtlasSetup\bin\Debug\Atlas\ELE\Installutil.exe",
                                             @"/i C:\Users\Iman\Documents\AtlasSetup\AtlasSetup\bin\Debug\Atlas\ELE\GTS.Clock.ELESchedulingService.exe");

        }

        private void btnSentinelKey_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process.Start(@".\Programms\Sentinel Key\Setup.exe");
        }

        private void treeCopyDetail_AfterExpand(object sender, TreeViewEventArgs e)
        {
            
            var rootDirectory = new DirectoryInfo(e.Node.FullPath);
            e.Node.Nodes.Clear();
           

              
                
                foreach (var directory in rootDirectory.GetDirectories())
                {
                    var childDirectoryNode = new TreeNode(directory.Name) { Tag = directory };

                        e.Node.Nodes.Add(childDirectoryNode);
                        e.Node.Nodes[e.Node.Nodes.Count - 1].Nodes.Add("");

                        

                }
                foreach (var file in rootDirectory.GetFiles())

                        e.Node.Nodes.Add(new TreeNode(file.Name));
            }

        private void btnIISConfig_Click(object sender, EventArgs e)
        {

            
            //MyCompany.IIS.IISController.CreateAppPool("IIS://localhost/W3SVC/AppPools", "MNBH");

            MyCompany.IIS.IISController.CreateSite("IIS://localhost/W3SVC", "OOPOO", @"J:\_IMAN_ATLAS_\Atlas", "*", "localhost", "4.0");

            


        }

        private void btnNet35_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process.Start(@".\Programms\.Net 3.5\Setup.exe");
        }

        private void btnSQLServer_Click(object sender, EventArgs e)
        {

        }

        private void btnNet4_Click(object sender, EventArgs e)
        {

        }

        private void btnNotepad_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process.Start(@".\Programms\Notepad++\Setup.exe");
        }

        private void btnISO_Click(object sender, EventArgs e)
        {

        }

        private void btnBiostar_Click(object sender, EventArgs e)
        {

        }

        private void btnFirefox_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process.Start(@".\Programms\Mozilla Firefox\Setup.exe");
        }

        private void btnPdfReader_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process.Start(@".\Programms\PDF Reader\Setup.exe");
        }

        private void btnVisualStudio_Click(object sender, EventArgs e)
        {

        }

        private void btnChrome_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process.Start(@".\Programms\Google Chrome\Setup.exe");
        }

        private void btnIIS_Click(object sender, EventArgs e)
        {

        }

        private void btnUnELE_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process.Start(@"C:\Users\Iman\Documents\AtlasSetup\AtlasSetup\bin\Debug\Atlas\ELE\Installutil.exe",
                                             @"/u C:\Users\Iman\Documents\AtlasSetup\AtlasSetup\bin\Debug\Atlas\ELE\GTS.Clock.ELESchedulingService.exe");

        }

        private void btnFiddler_Click(object sender, EventArgs e)
        {

        }

        private void btnToolbelt_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process.Start(@".\Programms\Red Gate SQL Toolbelt\Setup.exe");
        }

        private void btnReport_Click(object sender, EventArgs e)
        {
            
        }

        private void btnDecompile_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process.Start(@".\Programms\Telerik Just Decompile\Setup.exe");
        }

        private void btnSystemKey_Click(object sender, EventArgs e)
        {
            rtbConfigInfo.Text += "> سریال سیستم : "+"214500-874584-32540-87452-980021141" + "\n";
        }


            
        }


        
    }

