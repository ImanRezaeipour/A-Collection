using System;
using System.Threading;
using System.Windows.Forms;
using System.Configuration;

namespace AtlasTrafficReader
{
    public partial class MainForm : Form
    {
        private Thread thread;
        private bool threadrun = false;

        public MainForm()
        {
            InitializeComponent();
        }

        public void Progress(int value)
        {
            prgImport.Value += value;
        }

        private void Do()
        {
            Classes.XLS xls = new Classes.XLS();
            xls.NewFiles();
            timerInfo.Stop();
            rtbInfo.Text = "ENDED.\n";
            prgImport.Value = 0;
            lblFileName.Text = "";
            lblPercent.Text = "";
            btnImport.Enabled = true;
            btnCancel.Visible = false;
        }

        private void AutoDo()
        {
            Classes.XLS xls = new Classes.XLS();
            xls.NewFiles();
        }

        private void btnImport_Click(object sender, EventArgs e)
        {
            CheckForIllegalCrossThreadCalls = false;
            rtbInfo.Text = "";
            btnImport.Enabled = false;
            btnCancel.Visible = true;
            btnCancel.Text = "Pause Importing";
            timerInfo.Start();
            thread = new Thread(Do);
            thread.Start();
            threadrun = true;
        }

        private void btnAutomatic_Click(object sender, EventArgs e)
        {
            btnAutomatic.Enabled = false;
            btnStop.Enabled = true;
            AutoDo();
            timer.Interval = Convert.ToInt32(ConfigurationManager.AppSettings["MinutesTimeOut"]) * 60000;
            timer.Start();
        }

        private void timer_Tick(object sender, EventArgs e)
        {
            AutoDo();
        }

        private void btnStop_Click(object sender, EventArgs e)
        {
            timer.Stop();
            btnStop.Enabled = false;
            btnAutomatic.Enabled = true;
        }

        private void MainForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            DialogResult dr = MessageBox.Show(
                "Are you sure?",
                "Exit",
                MessageBoxButtons.YesNo,
                MessageBoxIcon.Question,
                MessageBoxDefaultButton.Button2);
            if (dr == DialogResult.No) {
                thread.Abort();
                e.Cancel = true; }
        }

        private void timerInfo_Tick(object sender, EventArgs e)
        {
            //rtbInfo.Text = Classes.Info.Message;

            rtbInfo.Text = "Sheets Remaining: " + Classes.Info.SheetRemain.ToString()+"\n";

            if (Classes.Info.Progress > 100)
                prgImport.Value = 100;
            else
                prgImport.Value = Classes.Info.Progress;
            lblPercent.Text = "";
            lblPercent.Text = Classes.Info.Progress.ToString() + "%";
            lblFileName.Text = Classes.Info.File;
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            if (threadrun == true)
            {
                thread.Suspend();
                timerInfo.Stop();
                btnCancel.Text = "Resume Importing";
                threadrun = false;
            }
            else if (threadrun == false)
            {
                thread.Resume();
                timerInfo.Start();
                btnCancel.Text = "Pause Importing";
                threadrun = true;
            }
        }

        private void MainForm_Load(object sender, EventArgs e)
        {
            lblFileName.Text = "";
            lblPercent.Text = "";
        }
    }
}
