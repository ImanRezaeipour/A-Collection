using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Data.OleDb;

namespace AtlasTrafficReader
{
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
        }

        private void btnImport_Click(object sender, EventArgs e)
        {
            Classes.XLS xls = new Classes.XLS();
            xls.NewFiles();
            System.Windows.Forms.MessageBox.Show("success", "END");
        }

        private void MainForm_Load(object sender, EventArgs e)
        {

        }
    }
}
