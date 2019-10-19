using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EpicWarCL
{
    interface IDesignable
    {
        void setBackgroundShipImage();
        void setDefaultHardpoints();
        HardpointLayout getHardpoints();
    }
}
