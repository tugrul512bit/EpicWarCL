using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace EpicWarCL
{
    public partial class ShipDesign : Form,IDesignable
    {
        public ShipDesign()
        {
            InitializeComponent();
        }

        public HardpointLayout getHardpoints()
        {
            throw new NotImplementedException();
        }

        public void setBackgroundShipImage()
        {
            throw new NotImplementedException();
        }

        public void setDefaultHardpoints()
        {
            throw new NotImplementedException();
        }
    }
}
