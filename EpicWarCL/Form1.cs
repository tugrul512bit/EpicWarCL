using Cekirdekler;
using Cekirdekler.ClArrays;
using Cekirdekler.Hardware;
using Cekirdekler.Pipeline.Pool;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace EpicWarCL
{
    public partial class Form1 : Form
    {

        Button[] but { get; set; }
        float scale = 1.0f;
        float currentScale = 1.0f;
        const bool GAME_STATE_PLAYING = false;
        const bool GAME_STATE_BENCHMARKING = true;
        bool gameState = GAME_STATE_PLAYING;
        bool mouseDown = false;
        float lastMouseX = 0f;
        float lastMouseY = 0f;

        float currentMouseX = 0f;
        float currentMouseY = 0f;

        float deltaMouseX = 0f;
        float deltaMouseY = 0f;

        ComputeEngine engine { get; set; }

        public class ControlWriter : TextWriter
        {
            private Control textbox;
            public ControlWriter(Control textbox)
            {
                this.textbox = textbox;
            }

            public override void Write(char value)
            {
                textbox.Invoke((MethodInvoker)delegate
                {
                    textbox.Text += value;
                });

            }

            public override void Write(string value)
            {
                textbox.Invoke((MethodInvoker)delegate
                {
                    textbox.Text += value;
                });
            }

            public override Encoding Encoding
            {
                get { return Encoding.ASCII; }
            }
        }

        class ModuleNameId
        {
            public int id { get; set; }
            public string name { get; set; }
        }

        void addModuleItems(ComboBox cb)
        {
            List<ModuleNameId> ds = new List<ModuleNameId>();
            ds.Add(new ModuleNameId() { id = ComputeEngine.moduleTypePower, name = "Power Source" });
            ds.Add(new ModuleNameId() { id = ComputeEngine.moduleTypeTurret, name = "Cannon Turret" });
            ds.Add(new ModuleNameId() { id = ComputeEngine.moduleTypeShield, name = "Shield Generator" });
            ds.Add(new ModuleNameId() { id = ComputeEngine.moduleTypeEnergy, name = "Energy Capacitor" });
            ds.Add(new ModuleNameId() { id = ComputeEngine.moduleTypeTurretTurbo, name = "Turbo Cannon Turret" });
            cb.DataSource =ds;
            cb.DisplayMember = "name";
            cb.ValueMember = "id";
        
        }

        int playModeW= 1468;
        int playModeH = 654;

        public Form1()
        {


            InitializeComponent();

            Console.WriteLine("soundtrack");

            Console.WriteLine("soundtrack 2");

            this.DoubleBuffered = true;
            this.ResizeRedraw = false;
            
            this.MouseWheel += Form1_MouseWheel;
            this.MouseDown += Form1_MouseDown;
            this.MouseUp += Form1_MouseUp;
            this.MouseMove += Form1_MouseMove;

            System.Reflection.Assembly assembly = System.Reflection.Assembly.GetExecutingAssembly();
            FileVersionInfo fvi = FileVersionInfo.GetVersionInfo(assembly.Location);
            this.Text = "Epic War CL - v" + fvi.FileVersion;

            pictureBox1.Image = Image.FromFile("img/ship.png");

            
            module0.DropDownStyle = ComboBoxStyle.DropDownList;
            module1.DropDownStyle = ComboBoxStyle.DropDownList;
            module2.DropDownStyle = ComboBoxStyle.DropDownList;
            module3.DropDownStyle = ComboBoxStyle.DropDownList;
            module4.DropDownStyle = ComboBoxStyle.DropDownList;
            module5.DropDownStyle = ComboBoxStyle.DropDownList;
            module6.DropDownStyle = ComboBoxStyle.DropDownList;
            module7.DropDownStyle = ComboBoxStyle.DropDownList;
            module8.DropDownStyle = ComboBoxStyle.DropDownList;
            module9.DropDownStyle = ComboBoxStyle.DropDownList;
            
            
            addModuleItems(module0);
            addModuleItems(module1);
            addModuleItems(module2);
            addModuleItems(module3);
            addModuleItems(module4);
            addModuleItems(module5);
            addModuleItems(module6);
            addModuleItems(module7);
            addModuleItems(module8);
            addModuleItems(module9);

            moduleId[0] = ComputeEngine.moduleTypePower;
            moduleId[1] = ComputeEngine.moduleTypePower;
            moduleId[2] = ComputeEngine.moduleTypePower;
            moduleId[3] = ComputeEngine.moduleTypePower;
            moduleId[4] = ComputeEngine.moduleTypePower;
            moduleId[5] = ComputeEngine.moduleTypePower;
            moduleId[6] = ComputeEngine.moduleTypePower;
            moduleId[7] = ComputeEngine.moduleTypePower;
            moduleId[8] = ComputeEngine.moduleTypePower;
            moduleId[9] = ComputeEngine.moduleTypePower;

            this.ResizeBegin += (s, e) => { this.SuspendLayout(); };
            this.ResizeEnd += (s, e) => { this.ResumeLayout(true); };
            this.Move += (s, e) => { this.SuspendLayout(); };
            this.FormBorderStyle = FormBorderStyle.FixedSingle;
        }



        private void Form1_MouseWheel(object sender, MouseEventArgs e)
        {
            if (userControl)
            {
                if (e.Delta > 0)
                    scale *= 0.95f;
                else
                    scale *= 1.05f;
                lastMouseX = e.X;
                lastMouseY = e.Y;

                currentMouseX = e.X;
                currentMouseY = e.Y;
                deltaMouseX = 0f;
                deltaMouseY = 0f;
                mouseMovementX = e.X;
                mouseMovementY = e.Y;
            }
        }

        bool rightClick = false;
        private void Form1_MouseDown(object sender, MouseEventArgs e)
        {
            if (userControl)
            {
                if (e.Button == MouseButtons.Left)
                {
                    mouseDown = true;
                    lastMouseX = e.X;
                    lastMouseY = e.Y;

                    currentMouseX = e.X;
                    currentMouseY = e.Y;
                    mouseMovementX = e.X;
                    mouseMovementY = e.Y;
                    mouseUp = false;
                    mouseDownOld = true;
                }
                else if (e.Button == MouseButtons.Right)
                {
                    rightClick = true;
                }
            }
        }

        bool mouseUp = false;
        private void Form1_MouseUp(object sender, MouseEventArgs e)
        {
            if (userControl)
            {
                if (e.Button == MouseButtons.Left)
                {
                    mouseMovementX = e.X;
                    mouseMovementY = e.Y;

                    mouseDown = false;
                    mouseUp = true;
                    mouseUpOld = true;
                }
                else if (e.Button == MouseButtons.Right)
                {
                    rightClick = false;
                }
            }
        }
        float mouseMovementX { get; set; }
        float mouseMovementY { get; set; }
        private void Form1_MouseMove(object sender, MouseEventArgs e)
        {
            if (userControl)
            {

                if (mouseDown)
                {
                    lastMouseX = currentMouseX;
                    lastMouseY = currentMouseY;

                    currentMouseX = e.X;
                    currentMouseY = e.Y;
                    deltaMouseX = currentMouseX - lastMouseX;
                    deltaMouseY = currentMouseY - lastMouseY;

                }


                mouseMovementX = e.X;
                mouseMovementY = e.Y;
                if (mouseDownOld)
                {
                    mouseDownOld = false;
                }
            }
        }

        int selectedDeviceId = 0;
        private void mp3err(object pMediaObject)
        {
            MessageBox.Show("Cannot play media file.");
        }
        private void Form1_Shown_1(Object sender, EventArgs e)
        {

            GC.Collect();
            ClDevices dvc = ClPlatforms.all().gpus();

            int n = dvc.Length;
            List<Button> lb = new List<Button>();
            for (int i = 0; i < n; i++)
            {
                Button b = new Button();
                b.Text = dvc[i].logInfo();
                b.Left = 25;
                b.Top = 30 + 40 * i;
                b.Width = 255;
                lb.Add(b);
                
                GC.Collect();
            }
            but = lb.ToArray();
            for (int i = 0; i < but.Length; i++)
            {
                int iL = i;
                but[iL].Visible = false;
                this.Invoke((MethodInvoker)delegate
                {
                    if (but[iL] != null)
                    {
                        this.Controls.Add(but[iL]);

                        but[iL].Click += delegate
                        {
                            selectedDeviceId = iL;
                            for (int j = 0; j < but.Length; j++)
                            {
                                if (but[j] != null)
                                {
                                    int jL = j;
                                    but[jL].Invoke((MethodInvoker)delegate { but[jL].Visible = false; });
                                    menuStrip1.Invoke((MethodInvoker)delegate { menuStrip1.Visible = false; });
                                }
                            }
                            this.Invoke((MethodInvoker)delegate {
                                this.Text += " Loading.... please wait until kernels are compiled for GPU.";

                            });
                            panel2.Invoke((MethodInvoker)delegate {
                                panel2.Height = 50;
                            });
                            backgroundWorker1.RunWorkerAsync();
                            Console.WriteLine(iL);
                        };
                        
                    }
                });
            }
        }




        bool started = false;



        object syncObjPipelineStage = new object();

        Stopwatch swSecond = new Stopwatch();
        double fpsVal = 0;
        int frameCtr0 = 0;

        int selectedListViewIndexToModuleBitField(int ind)
        {
            if (ind == 0)
                return 1;
            else if (ind == 1)
                return 2;
            else if (ind == 2)
                return 4;
            else if (ind == 3)
                return 8;
            else
                return 0;
        }

        Bitmap bmpTmp = null;
        Bitmap bmpTmpDoubleBuffer = null;
        Graphics g0 = null;




        protected override void OnPaint(PaintEventArgs e)
        {
            base.OnPaint(e);
 
            e.Graphics.CompositingMode = System.Drawing.Drawing2D.CompositingMode.SourceCopy;
            e.Graphics.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighSpeed;
            e.Graphics.PixelOffsetMode = System.Drawing.Drawing2D.PixelOffsetMode.None;
            e.Graphics.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.NearestNeighbor;
            e.Graphics.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighSpeed;
            if (engine != null)
            {
                lock (engine)
                {
                    if (engine.texturesReady())
                    {
                        bmpTmp = engine.getCurrentTextureOfPipelineOutput();
                        var px = bmpTmp.GetPixel(0, 0);
                        if ((px.A == 0) || (px.IsEmpty))
                        {
                            Console.WriteLine("bad image pixel");
                            return;
                        }
                        if (bmpTmp != null)
                        {
                            lock (bmpTmp)
                            {
                                e.Graphics.DrawImage(bmpTmp, 0, 0);
                                e.Graphics.Flush(System.Drawing.Drawing2D.FlushIntention.Sync);

                                // backup frame when main frame not ready
                                /*
                                if (bmpTmpDoubleBuffer==null)
                                {
                                    bmpTmpDoubleBuffer = new Bitmap(bmpTmp.Width, bmpTmp.Height);
                                }
                                if (g0 == null)
                                {
                                    g0 = Graphics.FromImage(bmpTmpDoubleBuffer);
                                }

                                
                                g0.CompositingMode = System.Drawing.Drawing2D.CompositingMode.SourceCopy;
                                g0.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighSpeed;
                                g0.PixelOffsetMode = System.Drawing.Drawing2D.PixelOffsetMode.None;
                                g0.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.NearestNeighbor;
                                g0.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighSpeed;
                                g0.DrawImage(bmpTmp, 0, 0);
                                */
                            }
                            if (swSecond.ElapsedMilliseconds >= 1000)
                            {
                                fpsVal = 1000.0 * frameCtr0 / (double)swSecond.ElapsedMilliseconds;
                                swSecond.Reset();
                                swSecond.Start();
                                frameCtr0 = 0;
                            }
                            frameCtr0++;
                        }
                    }
                    else
                    {
                        if(bmpTmpDoubleBuffer!=null)
                        {
                            e.Graphics.DrawImage(bmpTmpDoubleBuffer, 0, 0);
                        }
                    }

                }
            }

        }


        WMPLib.WindowsMediaPlayer wplayer = new WMPLib.WindowsMediaPlayer();
        bool firstRun = true;
        object syncObjComputing = new object();
        Stopwatch swMouseDown = new Stopwatch();
        bool mouseDownOld = false;
        bool mouseUpOld = false;
        int []moduleId = new int[10];
        object objTerminateSync = new object();
        bool terminate = false;
        bool benchmarking = false;
        object startedSync = new object();
        bool startedAlready = false;
        private void backgroundWorker1_DoWork(object sender, DoWorkEventArgs e)
        {
            lock(startedSync)
            {
                startedAlready = true;
            }
            engine.setNumCaptains((int)numericUpDown3.Value);
            int iW = (int)numericUpDown1.Value;
            int iH = (int)numericUpDown2.Value;
            if((iW%64)!=0)
            {
                iW += (64 - (iW % 64));
            }
            if ((iH % 64) != 0)
            {
                iH += (64 - (iH % 64));
            }
            engine.setRenderWidth(iW);
            engine.setRenderHeight(iH);

            Stopwatch sw0 = new Stopwatch();
            Stopwatch sw01 = new Stopwatch();
            sw0.Start();
            sw01.Start();
            Stopwatch sw = new Stopwatch();
 
            swMouseDown.Start();
            
            swSecond.Start();

            double countWait = 0.00001;

            this.Invoke((MethodInvoker)delegate
            {
                label37.Invoke((MethodInvoker)delegate {
                    label37.Visible = false;
                });
                label37.Invalidate();

                label2.Invoke((MethodInvoker)delegate
                {
                    label2.Visible = false;
                });
                label2.Invalidate();
                label3.Invoke((MethodInvoker)delegate
                {
                    label3.Visible = false;
                });
                label3.Invalidate();
                numericUpDown1.Invoke((MethodInvoker)delegate
                {
                    numericUpDown1.Visible = false;
                });
                numericUpDown2.Invoke((MethodInvoker)delegate
                {
                    numericUpDown2.Visible = false;
                });
                numericUpDown1.Invalidate();
                numericUpDown2.Invalidate();
                tabControl1.Invoke((MethodInvoker)delegate
                {
                    tabControl1.Visible = false;
                });
                panel1.Invoke((MethodInvoker)delegate
                {
                    panel1.Visible = false;
                });
                tabControl2.Invoke((MethodInvoker)delegate
                {
                    tabControl2.Visible = false;
                });

                hScrollBar1.Invoke((MethodInvoker)delegate
                {
                    hScrollBar1.Visible = false;
                });


                label35.Invoke((MethodInvoker)delegate
                {
                    label35.Visible = false;
                });

                label36.Invoke((MethodInvoker)delegate
                {
                    label36.Visible = false;
                });

                /*
                label1.Invoke((MethodInvoker)delegate
                {
                    label1.Width = 256;
                });
                */
                this.Invoke((MethodInvoker)delegate {
                    //panel2.Visible = false;
                    panel2.Width = 290;
                });

                this.MaximumSize = new Size(engine.getRenderWidth() + 15, engine.getRenderHeight() + 59);
                lock (teamSync)
                {
                    if (benchModeSelected)
                    {
                        this.Width = windowStartWidth;
                        this.Height = windowStartHeight;
                        //if(windowStartWidth==1920)
                        //{
                        //    if ((Screen.PrimaryScreen.Bounds.Width <= 1980) || (Screen.PrimaryScreen.Bounds.Height <= 1080))
                        //        fullScreen();
                        //}
                    }
                    else
                    {
                        this.Width = engine.getRenderWidth();
                        this.Height = engine.getRenderHeight();
                    }
                    
                }
            });

            lock (teamSync)
            {
                engine.setTeam(team);
            }
            Console.WriteLine("team="+team);
            if(gameState != GAME_STATE_BENCHMARKING)
                engine.allocateArrays();
            engine.init(selectedDeviceId,moduleId);

            this.Invoke((MethodInvoker)delegate { this.Text = this.Text.Replace(" Loading.... please wait until kernels are compiled for GPU.", ""); });


            int benchCtr = 0;
            // 354: projectile=256, ship=64
            // 356: projectile=256, ship=256
            // 356: projectile=64, ship=256
            // 355: projectile=64, ship=64

            // 112: projectile=64, ship=64
            // 113: projectile=64, ship=256
            // 113: projectile=256, ship=256
            // 113: projectile=256, ship=64

            // 106: projectile=256, ship=64
            // 105: projectile=64, ship=64
            // 106: projectile=256, ship=256
            // 106: projectile=64, ship=256

            long bT = 300000;
            lock(benchTimeSync)
            {
                lock (teamSync)
                {
                    if (benchModeSelected)
                    {
                        bT = benchmarkTimeMilliseconds;
                    }
                }
            }
            if (benchModeSelected)
            {
                if (windowStartWidth == 1920)
                {
                    wplayer.MediaError += new WMPLib._WMPOCXEvents_MediaErrorEventHandler(mp3err);
                    wplayer.settings.volume = 100;
                    wplayer.controls.currentPosition = 33.0;
                    wplayer.URL = "msc/FlowerDuet.mp3";
                    wplayer.controls.play();
                    if ((Screen.PrimaryScreen.Bounds.Width <= 1980) || (Screen.PrimaryScreen.Bounds.Height <= 1080))
                        fullScreen();
                }
                else if(windowStartWidth==1280)
                {
                    wplayer.MediaError += new WMPLib._WMPOCXEvents_MediaErrorEventHandler(mp3err);
                    wplayer.settings.volume = 100;
                    wplayer.controls.currentPosition = 19.65;
                    wplayer.URL = "msc/AllaTurca.mp3";
                    wplayer.controls.play();
                }
            }
          

            while (sw.ElapsedMilliseconds < bT)
            {
                sw.Start();
                benchCtr++;
                lock (limitFpsSyncObj)
                {
                    if (limitFps30)
                    {
                        Stopwatch swW = new Stopwatch();
                        swW.Start();
                        long t1 = swW.Elapsed.Ticks; // 100 ns
                        if(fpsVal>60.5)
                        {
                            countWait += 0.00002 * ((fpsVal - 60.0));
                        }

                        if (fpsVal < 59.5)
                        {
                            countWait -= 0.00015 * ((-fpsVal + 59.5));
                        }
                       
                        while ((swW.Elapsed.Ticks - t1)/(double)Stopwatch.Frequency < countWait)
                        {

                        }
                        
                    }
                }
               
                

                


                if (scale < 0.4f)
                    scale = 0.4f;
                currentScale += (scale - currentScale) * 0.02f;

                float tmpX = deltaMouseX ;
                float tmpY = deltaMouseY;
                if ((engine != null) && (!benchmarking))
                {
                    
                    engine.setCurrentScale(currentScale);
                    engine.addTranslationXWithCurrentScale(-tmpX);
                    deltaMouseX *= 0.98f;
                    engine.addTranslationYWithCurrentScale(-tmpY);
                    deltaMouseY *= 0.98f;
                    
                    engine.setCurrentMouseXByClick(currentMouseX);
                    engine.setCurrentMouseYByClick(currentMouseY);
                    engine.setMouseMovementX(mouseMovementX);
                    engine.setMouseMovementY(mouseMovementY);
                    engine.setMouseRightClick(rightClick);
                    if(gameState==GAME_STATE_BENCHMARKING)
                    {
                        benchmarking = true;
                    }
                }
                else if(engine != null)
                {
                    engine.lockUserControl();
                }


                if (mouseDownOld)
                {
                    swMouseDown.Reset();
                    swMouseDown.Start();
                    mouseDownOld = false;
                }
                
                if (mouseUpOld)
                {
                    if (swMouseDown.ElapsedMilliseconds < 150)
                    {
                        if(engine!=null)
                            engine.setMouseLeftClick(true); // mouse click;
                    }
                    else
                    {
                        if(engine!=null)
                            engine.setMouseLeftClick(false); // x mouse click;
                    }
                    swMouseDown.Reset();
                    swMouseDown.Start();
                    mouseUpOld = false;
                }
                else
                {
                    if(engine!=null)
                        engine.setMouseLeftClick(false);// x mouse click;
                }

                lock (keyboardLock)
                {
                    // show hardpoints on/off
                    if(hPressed)
                    {
                        if (engine != null)
                            engine.setShowHardpointsView(true);
                    }
                    else
                    {
                        if(engine!=null)
                            engine.setShowHardpointsView(false);
                    }


                    // show captains levels on/off
                    if (lPressed)
                    {
                        if(engine!=null)
                            engine.setShowCaptainLevelView(true);
                    }
                    else
                    {
                        if(engine!=null)
                            engine.setShowCaptainLevelView(false);
                    }
                }

                

                lock (syncObjComputing)
                {

                    if (stopComputing)
                    {
                        stopComputing = false;
                        break;
                    }
                }

                engine.nextTexturePipelineStep();
                Parallel.For(0, 3, threadId =>
                    {
                        if (threadId == 0)
                        {
                            if (engine != null)
                            {
                                lock (keyboardLock)
                                {
                                    engine.run();
                                }
                            }


                            sw01.Stop();
                            sw01.Reset();
                            sw01.Start();

                            sw0.Stop();

                            sw0.Reset();
                            sw0.Start();
                        }
                        else if (threadId == 1)
                        {

                            if (engine != null)
                            {
                                lock (keyboardLock2)
                                {
                                    engine.copyTexturesDoubleBuffered();
                                }
                            }

                            this.Invalidate();

                        }
                        else if (threadId == 2)
                        {
                            lock (keyboardLock3)
                            {
                                if (engine != null)
                                {
                                    lock (engine)
                                    {
                                        if (engine.texturesReady())
                                        {
                                            if (bmpTmp != null)
                                            {
                                                lock (bmpTmp)
                                                {
                                                    if (bmpTmpDoubleBuffer == null)
                                                    {
                                                        bmpTmpDoubleBuffer = new Bitmap(bmpTmp.Width, bmpTmp.Height);
                                                    }
                                                    if (g0 == null)
                                                    {
                                                        g0 = Graphics.FromImage(bmpTmpDoubleBuffer);
                                                    }


                                                    g0.CompositingMode = System.Drawing.Drawing2D.CompositingMode.SourceCopy;
                                                    g0.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighSpeed;
                                                    g0.PixelOffsetMode = System.Drawing.Drawing2D.PixelOffsetMode.None;
                                                    g0.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.NearestNeighbor;
                                                    g0.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighSpeed;
                                                    g0.DrawImage(bmpTmp, 0, 0);
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    });

                lock(objTerminateSync)
                {
                    if (terminate || backgroundWorker1.CancellationPending)
                    {
                        Console.WriteLine("Terminated ############################");
                        Console.WriteLine("Terminated ############################");
                        Console.WriteLine("Terminated ############################");
                        Console.WriteLine("Terminated ############################");
                        Console.WriteLine("Terminated ############################");
                        Console.WriteLine("Terminated ############################");
                        Console.WriteLine("Terminated ############################");
                        break;
                    }
                }

            }
            menuStrip1.Invoke((MethodInvoker)delegate { menuStrip1.Visible = true; });
            if((gameState==GAME_STATE_BENCHMARKING) && (windowStartWidth>=1920) && (!windowedState))
            {
                lock (keyboardLock)
                    lock (keyboardLock2)
                        lock (keyboardLock3)
                            windowed();
            }
            this.Invoke((MethodInvoker)delegate { this.Text = this.Text + " ▁ ▂ ▄ ▅ ▆ ▇ █ Benchmark Score:" + string.Format("{0:#####.#}", engine.getCalcPoint()) + " █ ▇ ▆ ▅ ▄ ▂ ▁ "; });

            Console.WriteLine("bench frame counter="+ benchCtr);
            Console.WriteLine("benchmark finish time was reached!");
            lock (objTerminateSync)
            {
                terminated = true;
            }
            GC.Collect();
            if(backgroundWorker1.CancellationPending)
                Environment.Exit(0);

            this.Invoke((MethodInvoker)delegate {
                if(this.Text.Contains("Closing"))
                {
                    if (bmpTmp != null)
                    {
                        lock (bmpTmp)
                        {
                            if (engine != null)
                            {
                                lock (engine)
                                {
                                    Environment.Exit(0);
                                }
                            }
                        }
                    }
                }
            });
            

        }

        //int[] frameTimeHistory = new int[10];
        //int[] frameTimeHistory2= new int[10];

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void emailHuseyintugrulbuyukisikgmailcomToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Console.WriteLine("Emailing service not implemented.");
        }

        private void numericUpDown1_ValueChanged(object sender, EventArgs e)
        {

        }

        private void numericUpDown2_ValueChanged(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {

        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }



        private void tabPage4_Click(object sender, EventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        bool stopComputing = false;
        bool terminated = false;
        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            this.Text = "Closing.....................................................";
            Console.WriteLine("do events");

            //progressBar1.Visible = true;
            //progressBar1.BringToFront();
            //label102.Visible = true;
            
            //label102.BringToFront();
            /*
            for (int i = 0; i < 100; i++)
            {
                progressBar1.Invoke((MethodInvoker)delegate
                {
                    progressBar1.PerformStep();
                });
            }
            */
            Application.DoEvents();
            
            Console.WriteLine("started_0");

            lock (startedSync)
            {
                if (!startedAlready)
                    return;
            }
            Console.WriteLine("started");


            lock (objTerminateSync)
            {
                terminate = true;
            }

            if (backgroundWorker1.IsBusy)
            {
                e.Cancel = true;
                return;
            }

            bool tmpTerminated = false;
            Console.WriteLine("terminate");

            while (!tmpTerminated)
            {
                lock (objTerminateSync)
                {
                    tmpTerminated = terminated;
                }
                Thread.Sleep(10);
            }

            Console.WriteLine("if");
            if (engine != null)
            {
                Console.WriteLine("lock");
                lock (engine)
                {
                    engine.dispose();
                    Console.WriteLine("null");

                }
            }

        }

        ~Form1()
        {

        }

        private void allShipsStartWith1d8ShieldPointsToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }
        object cbSync = new object();
        bool detailLog = false;
        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            lock (cbSync)
            {
                engine.detailEnable(checkBox1.Checked);
            }
        }

        int oldNShip = 0;
        private void hScrollBar1_Scroll(object sender, ScrollEventArgs e)
        {
            if (userControl)
            {
                lock (syncObjComputing)
                {
                    int n = hScrollBar1.Value;
                    int n0 = 1;
                    for (int i = 0; i < n; i++)
                    {
                        n0 *= 2;
                    }
                    label36.Text = n0.ToString();
                    if (engine != null)
                    {
                        engine.setNumShipsThenAutoMapSize(n0);
                    }
                }
            }
        }

        private void label36_Click(object sender, EventArgs e)
        {

        }

        private void label35_Click(object sender, EventArgs e)
        {

        }
        bool limitFps30 = false;
        object limitFpsSyncObj = new object();
        private void checkBox2_CheckedChanged(object sender, EventArgs e)
        {
            lock (limitFpsSyncObj)
            {
                limitFps30 = checkBox2.Checked;
            }
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            moduleId[0] = ((ModuleNameId)((ComboBox)sender).SelectedItem).id;
        }

        private void comboBox8_SelectedIndexChanged(object sender, EventArgs e)
        {
            moduleId[1] = ((ModuleNameId)((ComboBox)sender).SelectedItem).id;
        }

        private void module2_SelectedIndexChanged(object sender, EventArgs e)
        {
            moduleId[2] = ((ModuleNameId)((ComboBox)sender).SelectedItem).id;
        }

        private void module3_SelectedIndexChanged(object sender, EventArgs e)
        {
            moduleId[3] = ((ModuleNameId)((ComboBox)sender).SelectedItem).id;
        }

        private void module4_SelectedIndexChanged(object sender, EventArgs e)
        {
            moduleId[4] = ((ModuleNameId)((ComboBox)sender).SelectedItem).id;
        }

        private void module5_SelectedIndexChanged(object sender, EventArgs e)
        {
            moduleId[5] = ((ModuleNameId)((ComboBox)sender).SelectedItem).id;
        }

        private void module6_SelectedIndexChanged(object sender, EventArgs e)
        {
            moduleId[6] = ((ModuleNameId)((ComboBox)sender).SelectedItem).id;
        }

        private void module7_SelectedIndexChanged(object sender, EventArgs e)
        {
            moduleId[7] = ((ModuleNameId)((ComboBox)sender).SelectedItem).id;
        }

        private void module8_SelectedIndexChanged(object sender, EventArgs e)
        {
            moduleId[8] = ((ModuleNameId)((ComboBox)sender).SelectedItem).id;
        }

        private void module9_SelectedIndexChanged(object sender, EventArgs e)
        {
            
            moduleId[9] = ((ModuleNameId)((ComboBox)sender).SelectedItem).id;
        }

        private void label11_Click(object sender, EventArgs e)
        {

        }
        public int team { get; set; }
        object teamSync = new object();
        private void button1_Click(object sender, EventArgs e)
        {
            if (userControl)
            {
                lock (teamSync)
                {
                    button2.Enabled = false;
                    button3.Enabled = false;
                    team = 0;
                }
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (userControl)
            {
                lock (teamSync)
                {
                    button1.Enabled = false;
                    button3.Enabled = false;
                    team = 1;
                }
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            if (userControl)
            {
                lock (teamSync)
                {
                    button1.Enabled = false;
                    button2.Enabled = false;
                    team = 2;
                }
            }
        }

        private void label37_Click(object sender, EventArgs e)
        {

        }

        private void tabPage1_Click(object sender, EventArgs e)
        {

        }

        private void label5_Click(object sender, EventArgs e)
        {

        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void label41_Click(object sender, EventArgs e)
        {

        }

        private void label6_Click(object sender, EventArgs e)
        {

        }

        object keyboardLock = new object();
        object keyboardLock2 = new object();
        object keyboardLock3 = new object();

        // toggle show hardpoints (and team color)
        bool hPressed = false;
        bool lPressed = false;

        protected override bool ProcessCmdKey(ref Message msg, Keys keyData)
        {
            lock (keyboardLock)
                lock (keyboardLock2)
                    lock (keyboardLock3)
                    {
                        if (keyData == Keys.Escape)
                        {
                            windowed();

                        }
                    }
            return base.ProcessCmdKey(ref msg, keyData);
        }
        private void Form1_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (userControl)
            {
                lock (keyboardLock)
                {
                    if (e.KeyChar.ToString().ToLower().Equals("h"))
                        hPressed = !hPressed;
                    if (e.KeyChar.ToString().ToLower().Equals("l"))
                        lPressed = !lPressed;
                   
                }
            }
        }

        private void Form1_KeyDown(object sender, KeyEventArgs e)
        {
 
        }

        private void Form1_PreviewKeyDown(object sender, PreviewKeyDownEventArgs e)
        {

        }

        private void numericUpDown3_ValueChanged(object sender, EventArgs e)
        {

        }

        private void rulesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Console.WriteLine("Game rules are still under development and may change.");
        }

        private void panel2_Paint(object sender, PaintEventArgs e)
        {

        }


        enum BenchmarkActionType
        {
            mapTranslateOverTime=1
        }

        /// <summary>
        /// benchmark object generates an array in GPU, that array is director of scene for each frame
        /// </summary>
        class BenchmarkAction
        {
            public BenchmarkActionType type { get; set; }
            public int startFrame { get; set; }
            public int stopFrame { get; set; }

            /// <summary>
            /// benchmark action type in opencl
            /// </summary>
            public int typeCode { get; set; }
        }



        void fullScreen()
        {
            this.Invoke((MethodInvoker)delegate
            {
                this.WindowState = FormWindowState.Normal;
                this.FormBorderStyle = FormBorderStyle.None;
                this.WindowState = FormWindowState.Maximized;
            });
        }

        bool windowedState = false;
        void windowed()
        {
            if (!windowedState)
            {
                windowedState = true;
                Console.WriteLine("esc");
                this.Invoke((MethodInvoker)delegate
                {
                    this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.Sizable;
                    this.WindowState = FormWindowState.Normal;
                    this.Width = 1280;
                    this.Height = 720;
                    this.Top = 0;
                    this.Left = 0;
                });
            }
        }

        bool userControl = true;
        int benchmarkTimeMilliseconds = 180000;

        string benchmarkKernels = @"



#define N_SCRIPT_WORKER @@scriptWorkerN@@

// Script engine commands
// executed by N_SCRIPT_WORKER workitems, controlled by 0th workitem
// pseudo opencl2.0 dynamic parallelism in opencl1.2
// *************************************************************
// *************************************************************

// commands

// waits for COMMAND_PARAMETER_0(c) miliseconds after time of this command
#define COMMAND_WAIT_MS @@uid@@

// waits for COMMAND_PARAMETER_0(c) miliseconds after beginning
#define COMMAND_WAIT_FOR_TOTAL_TIME @@uid@@

// waits until a frame no is reached
#define COMMAND_WAIT_FOR_FRAME @@uid@@

// bind command flow to a worker(parmeter0), jump current worker by step size(parmeter1)
#define COMMAND_BIND_WORKER @@uid@@

// check next command at leap point (N_SCRIPT_WORKER * step size) - (step size - 1)
// if it is BIND with same id, continue from that point
// else if, id==0, continue by leap 1
// else, stop worker
#define COMMAND_STOP_WORKER @@uid@@

// waits for all workers completed
#define COMMAND_SYNC_WORKER @@uid@@

// lock camera to ship center
#define COMMAND_LOCK_CAMERA_TO_SHIP @@uid@@

// move ships outside of map(close to negative infinity), they can't find enemy, move, attack there
#define COMMAND_MOVE_ALL_SHIPS_OUT @@uid@@

// move ships outside of map(close to negative infinity), they can't find enemy, move, attack there
// each ship is moved by a different worker
#define COMMAND_PARALLEL_MOVE_ALL_SHIPS_OUT @@uid@@

// enable hardpoint layout view for all ships
#define COMMAND_ENABLE_HARDPOINT_VIEW @@uid@@

// enable captain experience view for all ships
#define COMMAND_ENABLE_CAPTAIN_EXPERIENCE_VIEW @@uid@@


// create custom ship (with class, team, hardpoints, crew)
// using a pointer to a data block on integer data buffer
// which contains ship id, class type, team, crew, hardpoint, position info
#define COMMAND_CREATE_SHIP_BY_DATA @@uid@@

// create custom ship (with class, team, hardpoints, crew)
// using a pointer to a data block on integer data buffer
// which contains ship id, class type, team, crew, hardpoint, position info
#define COMMAND_PARALLEL_CREATE_SHIP_BY_DATA @@uid@@

// move ship instantly
#define COMMAND_MOVE_SHIP @@uid@@

// set target location for ship to move itself
#define COMMAND_SET_SHIP_MOVE_TARGET @@uid@@

// set target ship for a ship to move itself
#define COMMAND_SET_SHIP_SHIP_TARGET @@uid@@

// gets ship(from id in commandData) coordinates into data[c] and data[c+1]
#define COMMAND_GET_SHIP_COORDINATES_TO_DATA @@uid@@


// for loop begin
// next int value is counter(as start value)
// next is limit (exclusive)
// increments
// executes all commands inside
// nesting not supported
#define COMMAND_FLOW_FOR_BEGIN @@uid@@

// i is index in commands array that points to for loop begin
// used in script engine
#define COMMAND_FLOW_FOR_COUNTER(i) (commands[i+1])
#define COMMAND_FLOW_FOR_LIMIT(i) (commands[i+2])

// for loop end
#define COMMAND_FLOW_FOR_END @@uid@@

// instantly move camera to x,y position on map which is defined on float scriptData array
// uses 2 parameters  (if command is 5th on int array, x=6th on float, y=7th on float)
#define COMMAND_WARP_CAMERA @@uid@@

// change scale, use parameter 0
#define COMMAND_ZOOM_CAMERA @@uid@@

// command parameters are on float array(2x long)
#define COMMAND_PARAMETER_0(c) (2*c)
#define COMMAND_PARAMETER_1(c) (2*c+1)

#define COMMAND_DISABLE_MOUSE_POINTER @@uid@@
#define COMMAND_ENABLE_MOUSE_POINTER @@uid@@

// slowly move camera to x,y version of warp camera command
#define COMMAND_MOVE_CAMERA_TO_SHIP_ANIMATED @@uid@@
#define COMMAND_MOVE_CAMERA_BEGIN @@uid@@
#define COMMAND_MOVE_CAMERA_CURRENT_POS @@uid@@
#define COMMAND_MOVE_CAMERA_END @@uid@@

// array indices for all angine states in engineState array
#define ENGINE_STATE_PER_THREAD 15
#define ENGINE_STATE_FRAME_COUNT 0
#define ENGINE_STATE_WORKER_ACTIVE 1
#define ENGINE_STATE_WORKER_JUMP_SIZE 2
#define ENGINE_STATE_WORKER_NUM_JUMPS_LEFT 3
#define ENGINE_STATE_WORKER_RUNNING_COUNT 4

// user variables. mouse positions, camera positions, map properties, ...
// as array indices (float variables)
#define USER_VAR_MAP_SCALE 0

// camera position on map
#define USER_VAR_MAP_X 1
#define USER_VAR_MAP_Y 2

// mouse position on screen
#define USER_VAR_MOUSE_X 5
#define USER_VAR_MOUSE_Y 6

// user variables. integers (hardpoint view toggle, experience view toggle, ...)
#define USER_VAR_HARDPOINT_VIEW 12
#define USER_VAR_CAPTAIN_EXPERIENCE_VIEW 13


// time variables
// as array indices
#define TIME_TOTAL_ELAPSED 3
#define TIME_CHECKPOINT 4

// **************************************************************
// **************************************************************

            __kernel void incrementBenchmarkFrame(__global int * engineState)
            {
                int i=get_global_id(0);
                if(i==0)
                {
                    engineState[ENGINE_STATE_FRAME_COUNT]++;
                }
            }


            // todo: 1024 --> 4096 array alignment
            __constant uchar cruiserDesignAntiCorvette[11]={
                SHIP_MODULE_TYPE_CANNON_TURRET_TURBO,SHIP_MODULE_TYPE_CANNON_TURRET_TURBO,
                SHIP_MODULE_TYPE_CANNON_TURRET_TURBO,SHIP_MODULE_TYPE_CANNON_TURRET_TURBO,
                SHIP_MODULE_TYPE_CANNON_TURRET_CRUISER,SHIP_MODULE_TYPE_CANNON_TURRET_TURBO,
                SHIP_MODULE_TYPE_POWER_SOURCE_CRUISER,SHIP_MODULE_TYPE_POWER_SOURCE_CRUISER,
                SHIP_MODULE_TYPE_ENERGY_CAPACITOR_CRUISER,SHIP_MODULE_TYPE_ENERGY_CAPACITOR_CRUISER,
                3 /* cruiser */
            };

            __constant uchar cruiserDesignAntiCruiser[11]={
                SHIP_MODULE_TYPE_SHIELD_GENERATOR_CRUISER,SHIP_MODULE_TYPE_SHIELD_GENERATOR_CRUISER,
                SHIP_MODULE_TYPE_CANNON_TURRET_CRUISER,SHIP_MODULE_TYPE_CANNON_TURRET_CRUISER,
                SHIP_MODULE_TYPE_CANNON_TURRET_CRUISER,SHIP_MODULE_TYPE_CANNON_TURRET_CRUISER,
                SHIP_MODULE_TYPE_POWER_SOURCE_CRUISER,SHIP_MODULE_TYPE_POWER_SOURCE_CRUISER,
                SHIP_MODULE_TYPE_ENERGY_CAPACITOR_CRUISER,SHIP_MODULE_TYPE_ENERGY_CAPACITOR_CRUISER,
                3 /* cruiser */
            };

            __constant uchar cruiserDesignAntiFrigate[11]={
                SHIP_MODULE_TYPE_SHIELD_GENERATOR_CRUISER,SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_DESTROYER,
                SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_DESTROYER,SHIP_MODULE_TYPE_CANNON_TURRET_CRUISER,
                SHIP_MODULE_TYPE_CANNON_TURRET_CRUISER,SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_DESTROYER,
                SHIP_MODULE_TYPE_POWER_SOURCE_CRUISER,SHIP_MODULE_TYPE_POWER_SOURCE_CRUISER,
                SHIP_MODULE_TYPE_POWER_SOURCE_CRUISER,SHIP_MODULE_TYPE_ENERGY_CAPACITOR_CRUISER,
                3 /* cruiser */
            };

            __constant uchar frigateDesignAntiCorvette[11]={
                SHIP_MODULE_TYPE_CANNON_TURRET_TURBO,SHIP_MODULE_TYPE_CANNON_TURRET_TURBO,
                SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_FRIGATE,SHIP_MODULE_TYPE_POWER_SOURCE_FRIGATE,
                SHIP_MODULE_TYPE_POWER_SOURCE_FRIGATE,SHIP_MODULE_TYPE_POWER_SOURCE_FRIGATE,
                SHIP_MODULE_TYPE_POWER_SOURCE_FRIGATE,SHIP_MODULE_TYPE_SHIELD_GENERATOR_FRIGATE,
                SHIP_MODULE_TYPE_SHIELD_GENERATOR_FRIGATE,SHIP_MODULE_TYPE_SHIELD_GENERATOR_FRIGATE,
                1 /* frigate */
            };

            __constant uchar heavyFrigateDesignAntiCorvette[11]={
                SHIP_MODULE_TYPE_CANNON_TURRET_FRIGATE,SHIP_MODULE_TYPE_CANNON_TURRET_FRIGATE,
                SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_FRIGATE,SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_FRIGATE,
                SHIP_MODULE_TYPE_POWER_SOURCE_FRIGATE,SHIP_MODULE_TYPE_POWER_SOURCE_FRIGATE,
                SHIP_MODULE_TYPE_POWER_SOURCE_FRIGATE,SHIP_MODULE_TYPE_POWER_SOURCE_FRIGATE,
                SHIP_MODULE_TYPE_ENERGY_CAPACITOR_CRUISER,SHIP_MODULE_TYPE_ENERGY_CAPACITOR_CRUISER,
                1 /* frigate */
            };

            __constant uchar destroyerDesignAntiCruiser[11]={
                SHIP_MODULE_TYPE_CANNON_TURRET_DESTROYER,SHIP_MODULE_TYPE_CANNON_TURRET_DESTROYER,
                SHIP_MODULE_TYPE_CANNON_TURRET_DESTROYER,SHIP_MODULE_TYPE_CANNON_TURRET_DESTROYER,
                SHIP_MODULE_TYPE_CANNON_TURRET_DESTROYER,SHIP_MODULE_TYPE_CANNON_TURRET_DESTROYER,
                SHIP_MODULE_TYPE_POWER_SOURCE_DESTROYER,SHIP_MODULE_TYPE_POWER_SOURCE_DESTROYER,
                SHIP_MODULE_TYPE_POWER_SOURCE_DESTROYER,SHIP_MODULE_TYPE_ENERGY_CAPACITOR_CRUISER,
                2 /* destroyer */
            };

            __constant uchar destroyerDesignAntiCorvette[11]={
                SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_DESTROYER,SHIP_MODULE_TYPE_CANNON_TURRET,
                SHIP_MODULE_TYPE_CANNON_TURRET,SHIP_MODULE_TYPE_CANNON_TURRET,
                SHIP_MODULE_TYPE_CANNON_TURRET,SHIP_MODULE_TYPE_CANNON_TURRET,
                SHIP_MODULE_TYPE_POWER_SOURCE_DESTROYER,SHIP_MODULE_TYPE_POWER_SOURCE_DESTROYER,
                SHIP_MODULE_TYPE_POWER_SOURCE_DESTROYER,SHIP_MODULE_TYPE_ENERGY_CAPACITOR_CRUISER,
                2 /* destroyer */
            };

            __constant uchar heavyCorvetteDesignAntiFrigate[11]={
                SHIP_MODULE_TYPE_SHIELD_GENERATOR,SHIP_MODULE_TYPE_SHIELD_GENERATOR,
                SHIP_MODULE_TYPE_CANNON_TURRET,SHIP_MODULE_TYPE_CANNON_TURRET,
                SHIP_MODULE_TYPE_POWER_SOURCE,SHIP_MODULE_TYPE_POWER_SOURCE,
                SHIP_MODULE_TYPE_POWER_SOURCE,SHIP_MODULE_TYPE_POWER_SOURCE,
                SHIP_MODULE_TYPE_ENERGY_CAPACITOR,SHIP_MODULE_TYPE_ENERGY_CAPACITOR,
                0 /* corvette */
            };



            __constant uchar corvetteDesignAntiCorvette[11]={
                SHIP_MODULE_TYPE_CANNON_TURRET_TURBO,SHIP_MODULE_TYPE_CANNON_TURRET,
                SHIP_MODULE_TYPE_SHIELD_GENERATOR,SHIP_MODULE_TYPE_SHIELD_GENERATOR,
                SHIP_MODULE_TYPE_POWER_SOURCE,SHIP_MODULE_TYPE_POWER_SOURCE,
                SHIP_MODULE_TYPE_ENERGY_CAPACITOR,SHIP_MODULE_TYPE_ENERGY_CAPACITOR,
                SHIP_MODULE_TYPE_SHIELD_GENERATOR,SHIP_MODULE_TYPE_SHIELD_GENERATOR,
                0 /* corvette */
            };


            void clearMap(int * adr, __global int * command)
            {
                command[(*adr)++]=COMMAND_MOVE_ALL_SHIPS_OUT; 
            }

            void disableMousePointer(int * adr, __global int * command)
            {
                command[(*adr)++]=COMMAND_DISABLE_MOUSE_POINTER; 
            }

            void enableMousePointer(int * adr, __global int * command)
            {
                command[(*adr)++]=COMMAND_ENABLE_MOUSE_POINTER; 
            }



            void enableHardpointView(int * adr, __global int * command)
            {
                command[(*adr)++]=COMMAND_ENABLE_HARDPOINT_VIEW; 
            }

            void enableCaptainExperienceView(int * adr, __global int * command)
            {
                command[(*adr)++]=COMMAND_ENABLE_CAPTAIN_EXPERIENCE_VIEW; 
            }


            void lockCameraToShipForTimeSpan(int shipId, float forMilisecond, int * adr, __global int * command, __global float * commandData)
            {
                command[*adr]=COMMAND_LOCK_CAMERA_TO_SHIP; 
                commandData[COMMAND_PARAMETER_0((*adr))]=(float)shipId; 
                commandData[COMMAND_PARAMETER_1((*adr))]=forMilisecond;
                (*adr)++;
            }

            void waitForTimePoint(int atMilisecond, int * adr, __global int * command,  __global float * commandData)
            {
                command[(*adr)]=COMMAND_WAIT_FOR_TOTAL_TIME;   
                commandData[COMMAND_PARAMETER_0((*adr))]=atMilisecond;     
                (*adr)++;
            }

            void warpCameraAtTime(int atMilisecond, float X, float Y, int * adr, __global int * command,  __global float * commandData)
            {
                command[(*adr)]=COMMAND_WAIT_FOR_TOTAL_TIME;   
                commandData[COMMAND_PARAMETER_0((*adr))]=atMilisecond;     
                (*adr)++;
                command[(*adr)]=COMMAND_WARP_CAMERA;    // define instant camera move action
                commandData[COMMAND_PARAMETER_0((*adr))]=X;      // define x of new cam position
                commandData[COMMAND_PARAMETER_1((*adr))]=Y;      // define y of new cam position
                (*adr)++;
            }

            void zoomCameraAtTime(int atMilisecond,float zoomScale, int * adr, __global int * command,  __global float * commandData)
            {
                command[(*adr)]=COMMAND_WAIT_FOR_TOTAL_TIME;  
                commandData[COMMAND_PARAMETER_0((*adr))]=atMilisecond;      
                (*adr)++;
                command[(*adr)]=COMMAND_ZOOM_CAMERA;    
                commandData[COMMAND_PARAMETER_0((*adr))]=zoomScale;    
                (*adr)++;
            }

            void waitForTimeSpan(float forMilisecond, int * adr, __global int * command, __global float * commandData)
            {
                command[(*adr)]=COMMAND_WAIT_MS; 
                commandData[COMMAND_PARAMETER_0((*adr))]=forMilisecond;
                (*adr)++;
            }

            void createShipAtScreenCenter(int shipId, uchar team, bool isMoving, float direction, float X, float Y, bool isCameraOrigin, 
                            __constant uchar * design, int * adr, int * dataAdr, 
                            __global int * command, __global float * commandData, __global int * dataInt,
                            __global float * dataFloat)
            {
                command[(*adr)]=COMMAND_CREATE_SHIP_BY_DATA; 
                commandData[COMMAND_PARAMETER_0((*adr))] = (float)(*dataAdr); // points to a data[] address
                dataInt[(*dataAdr)++]=shipId; // new ship's id value(position in array)
                dataFloat[(*dataAdr)++]=(isCameraOrigin?-1.0f:X); // create at (center of camera view if negative) X pixel
                dataFloat[(*dataAdr)++]=(isCameraOrigin?-1.0f:Y); // create at (center of camera view if negative) Y pixel
                dataFloat[(*dataAdr)++]=(isCameraOrigin?X:0.0f); // translation X if its created at camera view
                dataFloat[(*dataAdr)++]=(isCameraOrigin?Y:0.0f); // translation Y if its created at camera view
                dataInt[(*dataAdr)++]=team; // team number
                dataInt[(*dataAdr)++]=design[10]; // size class 0=corvette, 1=frigate, 2=destroyer, 3=cruiser
                dataInt[(*dataAdr)++]=design[0]; 
                dataInt[(*dataAdr)++]=design[1]; 
                dataInt[(*dataAdr)++]=design[2];
                dataInt[(*dataAdr)++]=design[3]; 
                dataInt[(*dataAdr)++]=design[4]; 
                dataInt[(*dataAdr)++]=design[5]; 
                dataInt[(*dataAdr)++]=design[6]; 
                dataInt[(*dataAdr)++]=design[7]; 
                dataInt[(*dataAdr)++]=design[8]; 
                dataInt[(*dataAdr)++]=design[9]; 
                dataInt[(*dataAdr)++]=(isMoving?1:0); // moving
                dataFloat[(*dataAdr)++]=direction; // direction
                (*adr)++;
            }

            void createShipAtMapCoordinate(int shipId, uchar team, bool isMoving, float direction, float X, float Y, 
                            __constant uchar * design, int * adr, int * dataAdr, 
                            __global int * command, __global float * commandData, __global int * dataInt,
                            __global float * dataFloat)
            {
                command[(*adr)]=COMMAND_CREATE_SHIP_BY_DATA; 
                commandData[COMMAND_PARAMETER_0((*adr))] = (float)(*dataAdr); // points to a data[] address
                dataInt[(*dataAdr)++]=shipId; // new ship's id value(position in array)
                dataFloat[(*dataAdr)++]=(X); // create at (center of camera view if negative) X pixel
                dataFloat[(*dataAdr)++]=(Y); // create at (center of camera view if negative) Y pixel
                dataFloat[(*dataAdr)++]=(0.0f); // translation X if its created at camera view
                dataFloat[(*dataAdr)++]=(0.0f); // translation Y if its created at camera view
                dataInt[(*dataAdr)++]=team; // team number
                dataInt[(*dataAdr)++]=design[10]; // size class 0=corvette, 1=frigate, 2=destroyer, 3=cruiser
                dataInt[(*dataAdr)++]=design[0]; 
                dataInt[(*dataAdr)++]=design[1]; 
                dataInt[(*dataAdr)++]=design[2];
                dataInt[(*dataAdr)++]=design[3]; 
                dataInt[(*dataAdr)++]=design[4]; 
                dataInt[(*dataAdr)++]=design[5]; 
                dataInt[(*dataAdr)++]=design[6]; 
                dataInt[(*dataAdr)++]=design[7]; 
                dataInt[(*dataAdr)++]=design[8]; 
                dataInt[(*dataAdr)++]=design[9]; 
                dataInt[(*dataAdr)++]=(isMoving?1:0); // moving
                dataFloat[(*dataAdr)++]=direction; // direction
                (*adr)++;
            }

            void placeShipAtTime(   int shipId, int atMiliseconds, bool isMoving, float direction, bool isCameraOrigin, float X, float Y,
                                    int * adr, int * dataAdr, __global int * command, __global float * commandData,
                                    __global int * dataInt, __global float * dataFloat)
            {
                command[(*adr)]=COMMAND_WAIT_FOR_TOTAL_TIME;  
                commandData[COMMAND_PARAMETER_0((*adr))]=atMiliseconds;     
                (*adr)++;
                command[(*adr)]=COMMAND_MOVE_SHIP; 
                commandData[COMMAND_PARAMETER_0((*adr))]=(float)(*dataAdr); // move ship with data of id, target coordinates
                dataInt[(*dataAdr)++]=shipId; // ship id
                dataFloat[(*dataAdr)++]=(isCameraOrigin?-1.0f:X); // X (negative means to camera)
                dataFloat[(*dataAdr)++]=(isCameraOrigin?-1.0f:Y); // Y (negative means to camera)
                dataFloat[(*dataAdr)++]=(isCameraOrigin?X:0.0f); // X translation from camera 
                dataFloat[(*dataAdr)++]=(isCameraOrigin?Y:0.0f); // Y translation from camera
                dataInt[(*dataAdr)++]=(isMoving?1:0); // moving
                dataFloat[(*dataAdr)++]=direction; // direction
                (*adr)++;
            }


            void placeShipAfterTimeSpan(   int shipId, int forMiliseconds, bool isMoving, float direction, bool isCameraOrigin, float X, float Y,
                                    int * adr, int * dataAdr, __global int * command, __global float * commandData,
                                    __global int * dataInt, __global float * dataFloat)
            {
                command[(*adr)]=COMMAND_WAIT_MS;  
                commandData[COMMAND_PARAMETER_0((*adr))]=forMiliseconds;     
                (*adr)++;
                command[(*adr)]=COMMAND_MOVE_SHIP; 
                commandData[COMMAND_PARAMETER_0((*adr))]=(float)(*dataAdr); // move ship with data of id, target coordinates
                dataInt[(*dataAdr)++]=shipId; // ship id
                dataFloat[(*dataAdr)++]=(isCameraOrigin?-1.0f:X); // X (negative means to camera)
                dataFloat[(*dataAdr)++]=(isCameraOrigin?-1.0f:Y); // Y (negative means to camera)
                dataFloat[(*dataAdr)++]=(isCameraOrigin?X:0.0f); // X translation from camera 
                dataFloat[(*dataAdr)++]=(isCameraOrigin?Y:0.0f); // Y translation from camera
                dataInt[(*dataAdr)++]=(isMoving?1:0); // moving
                dataFloat[(*dataAdr)++]=direction; // direction
                (*adr)++;
            }

            void translateShipAfterTimeSpan(   int shipId, int forMiliseconds, bool isMoving, bool isCameraOrigin, float X, float Y,
                                    int * adr, int * dataAdr, __global int * command, __global float * commandData,
                                    __global int * dataInt, __global float * dataFloat)
            {
                command[(*adr)]=COMMAND_WAIT_MS;  
                commandData[COMMAND_PARAMETER_0((*adr))]=forMiliseconds;     
                (*adr)++;
                command[(*adr)]=COMMAND_MOVE_SHIP; 
                commandData[COMMAND_PARAMETER_0((*adr))]=(float)(*dataAdr); // move ship with data of id, target coordinates
                dataInt[(*dataAdr)++]=shipId; // ship id
                dataFloat[(*dataAdr)++]=(isCameraOrigin?-1.0f:X); // X (negative means to camera)
                dataFloat[(*dataAdr)++]=(isCameraOrigin?-1.0f:Y); // Y (negative means to camera)
                dataFloat[(*dataAdr)++]=(isCameraOrigin?X:0.0f); // X translation from camera 
                dataFloat[(*dataAdr)++]=(isCameraOrigin?Y:0.0f); // Y translation from camera
                dataInt[(*dataAdr)++]=(isMoving?1:0); // moving
                dataFloat[(*dataAdr)++]=999999999.0f; // direction
                (*adr)++;
            }


            void translateShipAtTime(   int shipId, int atMiliseconds, bool isMoving, bool isCameraOrigin, float X, float Y,
                                    int * adr, int * dataAdr, __global int * command, __global float * commandData,
                                    __global int * dataInt, __global float * dataFloat)
            {
                command[(*adr)]=COMMAND_WAIT_FOR_TOTAL_TIME;  
                commandData[COMMAND_PARAMETER_0((*adr))]=atMiliseconds;     
                (*adr)++;
                command[(*adr)]=COMMAND_MOVE_SHIP; 
                commandData[COMMAND_PARAMETER_0((*adr))]=(float)(*dataAdr); // move ship with data of id, target coordinates
                dataInt[(*dataAdr)++]=shipId; // ship id
                dataFloat[(*dataAdr)++]=(isCameraOrigin?-1.0f:X); // X (negative means to camera)
                dataFloat[(*dataAdr)++]=(isCameraOrigin?-1.0f:Y); // Y (negative means to camera)
                dataFloat[(*dataAdr)++]=(isCameraOrigin?X:0.0f); // X translation from camera 
                dataFloat[(*dataAdr)++]=(isCameraOrigin?Y:0.0f); // Y translation from camera
                dataInt[(*dataAdr)++]=(isMoving?1:0); // moving
                dataFloat[(*dataAdr)++]=999999999.0f; // direction
                (*adr)++;
            }

#define parallelForScript(cmdAdr,commandArray,commandDataArray,iBegin,iEnd,jLoop,cBlock) \
{ \
    int adrDifference=0; \
    int nSerial=((iEnd-iBegin)%(N_SCRIPT_WORKER-1)); \
    int nParallel=(iEnd-iBegin)-nSerial; \
    int iParallelEnd=iBegin+nParallel; \
    for(int jLoop=iBegin;jLoop<iParallelEnd;jLoop++) \
    { \
        commandArray[cmdAdr]=COMMAND_BIND_WORKER;              \
        int tmpAdr=cmdAdr; \
        commandDataArray[COMMAND_PARAMETER_0(cmdAdr)]=1+jLoop%(N_SCRIPT_WORKER-1);  \
        cmdAdr++; \
        adrDifference = -cmdAdr; \
        cBlock \
        adrDifference+=cmdAdr;   \
        commandArray[cmdAdr++]=COMMAND_STOP_WORKER;           \
        commandDataArray[COMMAND_PARAMETER_1(tmpAdr)]=adrDifference+2; \
    } \
    int iSerialEnd=iParallelEnd+nSerial; \
    for(int jLoop=iParallelEnd;jLoop<iSerialEnd;jLoop++) \
    { \
        cBlock \
    } \
    commandArray[cmdAdr++]=COMMAND_SYNC_WORKER; \
}

                       
            void setShipMoveTarget(int shipId, float X, float Y, int * adr, int * dataAdr, __global int * command, 
                                   __global float * commandData, __global int * dataInt, __global float * dataFloat)
            {
                command[*adr]=COMMAND_SET_SHIP_MOVE_TARGET;
                commandData[COMMAND_PARAMETER_0(*adr)]=*dataAdr;
                dataInt[(*dataAdr)++]=shipId;
                dataFloat[(*dataAdr)++]=X;
                dataFloat[(*dataAdr)++]=Y;
                (*adr)++;
            } 

            void setShipShipTarget(int shipId, int targetShipId, int * adr, int * dataAdr, __global int * command, 
                                   __global float * commandData, __global int * dataInt, __global float * dataFloat)
            {
                command[*adr]=COMMAND_SET_SHIP_SHIP_TARGET;
                commandData[COMMAND_PARAMETER_0(*adr)]=*dataAdr;
                dataInt[(*dataAdr)++]=shipId;
                dataInt[(*dataAdr)++]=targetShipId;
                (*adr)++;
            } 



            void moveCameraToShipAnimated(int shipId,float forMilisecond, int * adr, int * dataAdr, 
                __global int * command, __global float *  commandData,__global int * dataInt, __global float * dataFloat)
            {
                command[*adr]=COMMAND_MOVE_CAMERA_TO_SHIP_ANIMATED;
                commandData[COMMAND_PARAMETER_0(*adr)]=(*dataAdr);
                dataInt[(*dataAdr)++]=shipId;
                dataFloat[(*dataAdr)++]=forMilisecond;
                dataFloat[(*dataAdr)++]=0.0f; // memory for current animation time (to calculate percentage of animation location)
                dataFloat[(*dataAdr)++]=0.0f; // memory for starting cam position x 
                dataFloat[(*dataAdr)++]=0.0f; // memory for starting cam position y
                (*adr)++; 
            }
     
__kernel void setup1080pBenchmarkScript(
                                        __global int * engineState, 
                                        __global int * command,    
                                        __global float * commandData,
                                        __global int * commandPointer,
                                        __global int * dataInt,
                                        __global float * dataFloat,
                                        __global uint * randBuf)
{
    int i=get_global_id(0);
    if(i==0)
    {
        if(engineState[ENGINE_STATE_FRAME_COUNT]==1)
        {
            int adr = 0; // command register
            int dataAdr = 0; // data register
            int trigMs=0;  // wait time
            for(int j=0;j<N_SCRIPT_WORKER;j++)
            {
                commandPointer[j]=0;
            }

            // clear map of all ships
            clearMap(&adr, command);
            disableMousePointer(&adr, command);  
            enableCaptainExperienceView(&adr, command);

            int teamBlue=2;
            int teamGreen=1;
            int teamRed=0;
            int newShipCreateId=0; // current ship id

            for(int j=0;j<20;j++)
            {
                float jx=(j/5)*100+200;
                float jy=(j%5)*100+200;
                createShipAtMapCoordinate(newShipCreateId++,teamRed, true, 45.0f, jx,jy, cruiserDesignAntiFrigate, 
                            &adr, &dataAdr, command, commandData, dataInt, dataFloat);
            }
            

            // 0= worker1, 254=worker255, worker0 is not usable
            parallelForScript(adr,command,commandData,0,255,j,
            {
                if(j==0)
                {
                    // lock camera pos to ship for whole benchmark duration
                    lockCameraToShipForTimeSpan(newShipCreateId-3, 120000.0f, &adr, command, commandData);
                }
                else if((j>=1) && (j<21))
                {
                    float rt=tw_rnd(randBuf,i)*3000.0f+250.0f;
                    for(int k=0;k<10000;k++)
                    {
                
                        int m=(j-1);
                        float mx=(m/5)*100+200;
                        float my=(m%5)*100+200;
                        translateShipAtTime(m,k*0.3f+rt, true, false, 
                            mx+k*0.97f,  my+k*0.97f,
                            &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                    }

                }
                else if(j==21)
                {
                    float currentZoom=1.0f;
                    int currentTime=10000;
                    for(int k=0;k<300;k++)
                    {    
                        currentZoom-=0.002; 
                        currentTime+=3;
                        zoomCameraAtTime(currentTime,currentZoom, &adr, command, commandData);
                    }
                    currentTime+=3000;
                    for(int k=0;k<300;k++)
                    {    
                        currentZoom+=0.05; 
                        currentTime+=3;
                        zoomCameraAtTime(currentTime,currentZoom, &adr, command, commandData);
                    }
                    currentTime+=5000;
                    for(int k=0;k<300;k++)
                    {    
                        currentZoom-=0.048; 
                        currentTime+=3;
                        zoomCameraAtTime(currentTime,currentZoom, &adr, command, commandData);
                    }
                    currentTime+=25000;
                    for(int k=0;k<300;k++)
                    {    
                        currentZoom+=0.048; 
                        currentTime+=3;
                        zoomCameraAtTime(currentTime,currentZoom, &adr, command, commandData);
                    }
                    currentTime+=5000;
                    for(int k=0;k<300;k++)
                    {    
                        currentZoom-=0.048; 
                        currentTime+=3;
                        zoomCameraAtTime(currentTime,currentZoom, &adr, command, commandData);
                    }
                    currentTime+=15000;
                    for(int k=0;k<300;k++)
                    {    
                        currentZoom+=0.025; 
                        currentTime+=3;
                        zoomCameraAtTime(currentTime,currentZoom, &adr, command, commandData);
                    }
                    currentTime+=3000;
                    for(int k=0;k<300;k++)
                    {    
                        currentZoom-=0.025; 
                        currentTime+=3;
                        zoomCameraAtTime(currentTime,currentZoom, &adr, command, commandData);
                    }
                }
                else if(j==22)
                {
                    int currentTime=10000;
                    waitForTimePoint(currentTime, &adr, command,  commandData);
                    currentTime+=10000;
                    for(int k=0;k<20;k++)
                        setShipMoveTarget(k,MAP_WIDTH/2.0f,MAP_HEIGHT, &adr, &dataAdr,command, 
                            commandData, dataInt, dataFloat);
                    waitForTimePoint(currentTime, &adr, command,  commandData);
                    currentTime+=7000;
                    for(int k=0;k<20;k++)
                        setShipMoveTarget(k,0,MAP_HEIGHT, &adr, &dataAdr,command, 
                            commandData, dataInt, dataFloat);

                    waitForTimePoint(currentTime, &adr, command,  commandData);
                    currentTime+=10000;
                    for(int k=0;k<20;k++)
                        setShipMoveTarget(k,MAP_WIDTH,2.0f*MAP_HEIGHT/3.0f, &adr, &dataAdr,command, 
                            commandData, dataInt, dataFloat);

                    waitForTimePoint(currentTime, &adr, command,  commandData);
                    
                    for(int k=0;k<20;k++)
                        setShipMoveTarget(k,MAP_WIDTH,MAP_HEIGHT/2.0f, &adr, &dataAdr,command, 
                            commandData, dataInt, dataFloat);
                }
                else if((j>=100) &&  (j<200))
                {
                    {
                        int k=j-100;
                        for(int l=0;l<5;l++)
                        {
                            float X=tw_rnd(randBuf,i)*19900.0f;
                            float Y=tw_rnd(randBuf,i)*19900.0f;
                            float rot=45.0f+180.0f;
                            int currentTeam=-1;
                            if(X+Y>20000.0f)
                                {currentTeam=teamBlue;}
                            else
                                {currentTeam=teamRed;rot-=180.0f;}
                                
                                createShipAtMapCoordinate(newShipCreateId++,currentTeam, true,rot, X,Y, cruiserDesignAntiCorvette, 
                                    &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                    
                        }
                        for(int l=0;l<20;l++)
                        {
                            float X=tw_rnd(randBuf,i)*19900.0f;
                            float Y=tw_rnd(randBuf,i)*19900.0f;
                            float rot=45.0f+180.0f;
                            int currentTeam=-1;
                            if(X+Y>20000.0f)
                                {currentTeam=teamBlue;}
                            else
                                {currentTeam=teamRed;rot-=180.0f;}
                                
                                createShipAtMapCoordinate(newShipCreateId++,currentTeam, true,rot, X,Y, destroyerDesignAntiCorvette, 
                                    &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                    
                        }
                        for(int l=0;l<200;l++)
                        {
                            float X=tw_rnd(randBuf,i)*19900.0f;
                            float Y=tw_rnd(randBuf,i)*19900.0f;
                            float rot=45.0f+180.0f;
                            int currentTeam=-1;
                            if(X+Y>20000.0f)
                                {currentTeam=teamBlue;}
                            else
                                {currentTeam=teamRed;rot-=180.0f;}
                            createShipAtMapCoordinate(newShipCreateId++,currentTeam, true,rot, X,Y, frigateDesignAntiCorvette, 
                                    &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                        }
                        for(int l=0;l<300;l++)
                        {
                            float X=tw_rnd(randBuf,i)*19900.0f;
                            float Y=tw_rnd(randBuf,i)*19900.0f;
                            float rot=45.0f+180.0f;
                            int currentTeam=-1;
                            if(X+Y>20000.0f)
                                {currentTeam=teamBlue;}
                            else
                                {currentTeam=teamRed;rot-=180.0f;}
                            createShipAtMapCoordinate(newShipCreateId++,currentTeam, true,rot, X,Y, corvetteDesignAntiCorvette, 
                                    &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                        }
                        waitForTimePoint(15000.0f, &adr, command,  commandData);
                        for(int l=0;l<300;l++)
                        {
                            float t=tw_rnd(randBuf,i)*(3.14f*2.0f);  // angle
                            float r=10000.0f + tw_rnd(randBuf,i)*500.0f;// distance
                            float rot=180.0f+t*(360.0f/(3.14f*2.0f));            // looking center
                            float X=r*cos(t)+10700.0f;
                            float Y=r*sin(t)+10700.0f;
                            createShipAtMapCoordinate(newShipCreateId++,teamGreen, true,rot, X,Y, corvetteDesignAntiCorvette, 
                                    &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                        }

                        waitForTimePoint(35000.0f, &adr, command,  commandData);
                        for(int l=0;l<200;l++)
                        {
                            float t=tw_rnd(randBuf,i)*(3.14f*2.0f);  // angle
                            float r=10000.0f + tw_rnd(randBuf,i)*500.0f;// distance
                            float rot=180.0f+t*(360.0f/(3.14f*2.0f));            // looking center
                            float X=r*cos(t)+10700.0f;
                            float Y=r*sin(t)+10700.0f;
                            createShipAtMapCoordinate(newShipCreateId++,teamGreen, true,rot, X,Y, frigateDesignAntiCorvette, 
                                    &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                        }
                    }
                }
            });
        }
    }
}

            __kernel void setup720pBenchmarkScript(
                                        __global int * engineState, 
                                        __global int * command,    
                                        __global float * commandData,
                                        __global int * commandPointer,
                                        __global int * dataInt,
                                        __global float * dataFloat,
                                        __global uint * randBuf)
            {
                int i=get_global_id(0);
                if(i==0)
                {
                    // at first frame, setup all scripts of benchmark
                    if(engineState[ENGINE_STATE_FRAME_COUNT]==1)
                    {   

                       int adr = 0; // command register
                       int dataAdr = 0; // data register
                       int trigMs=32000; 
                
                        
                       for(int j=0;j<N_SCRIPT_WORKER;j++)
                       {
                           commandPointer[j]=0;
                       }


                        // clear map of all ships
                        clearMap(&adr, command);

                        int newShipCreateId=0;

                        int teamBlue=2;
                        int teamGreen=1;
                        int teamRed=0;

                        int galactica=newShipCreateId;
                        createShipAtScreenCenter(newShipCreateId++,teamGreen, true, -30.0f, 0.0f,0.0f,true, cruiserDesignAntiCorvette, 
                            &adr, &dataAdr, command, commandData, dataInt, dataFloat);

                        
                        createShipAtScreenCenter(newShipCreateId,teamBlue, true, -30.0f, 150.0f,-60.0f,true, frigateDesignAntiCorvette, 
                            &adr, &dataAdr, command, commandData, dataInt, dataFloat);

                        int corellianCorvette=newShipCreateId;



                        // todo: add crew generation function (buildCruiserCrew(..))

                        enableMousePointer(&adr, command);

                        parallelForScript(adr,command,commandData,0,255,j,
                        {


                            if(j==2)
                            {
                                waitForTimeSpan(16000.0f, &adr, command, commandData);
                                setShipMoveTarget(newShipCreateId-1,0,MAP_HEIGHT/2.0f, &adr, &dataAdr,command, 
                                                    commandData, dataInt, dataFloat);
                            }
                            else if(j==3)
                            {
                                // ships coming out of warp
                                int ts=10500;
                                waitForTimeSpan(ts, &adr, command, commandData);
                                newShipCreateId++;
                                ts+=500;
                                for(int k=0;k<200;k++)
                                {
                                    float x0=900.0f+220.0f*tw_rnd(randBuf,i);
                                    float y0=360.0f-720.0f*tw_rnd(randBuf,i);
                                    createShipAtScreenCenter(newShipCreateId++,teamBlue, true, 180.0f,x0 ,y0,true, corvetteDesignAntiCorvette, 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                    
                                    setShipShipTarget(newShipCreateId-1,galactica, &adr, &dataAdr,command, 
                                                    commandData, dataInt, dataFloat);

                                    for(int m=0;m<100;m++)
                                        translateShipAtTime(newShipCreateId-1,ts+=3, true, true, 
                                            x0-m*7.5f+k*15.0f,  y0,
                                            &adr, &dataAdr, command, commandData, dataInt, dataFloat);

                                }

                            }
                            else if((j>=4) && (j<104))
                            {
                                int spawnId=j-4; // 0...99
                                waitForTimeSpan(18500, &adr, command, commandData);
                                for(int k=0;k<3;k++)
                                {
                                    float x0=12000.0f*tw_rnd(randBuf,i)-6000.0f;
                                    float y0=-6000.0f*tw_rnd(randBuf,i)-500.0f;
                                    createShipAtScreenCenter(newShipCreateId++,teamGreen, true, 80.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,true, cruiserDesignAntiCruiser, 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }
                                for(int k=0;k<12;k++)
                                {
                                    float x0=12000.0f*tw_rnd(randBuf,i)-6000.0f;
                                    float y0=-6000.0f*tw_rnd(randBuf,i)-500.0f;
                                    createShipAtScreenCenter(newShipCreateId++,teamGreen, true, 80.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,true,destroyerDesignAntiCruiser , 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }
                                for(int k=0;k<20;k++)
                                {
                                    float x0=12000.0f*tw_rnd(randBuf,i)-6000.0f;
                                    float y0=-6000.0f*tw_rnd(randBuf,i)-500.0f;
                                    createShipAtScreenCenter(newShipCreateId++,teamGreen, true, 80.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,true,heavyFrigateDesignAntiCorvette , 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }
                                for(int k=0;k<50;k++)
                                {
                                    float x0=12000.0f*tw_rnd(randBuf,i)-6000.0f;
                                    float y0=-6000.0f*tw_rnd(randBuf,i)-500.0f;
                                    createShipAtScreenCenter(newShipCreateId++,teamGreen, true, 80.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,true, heavyCorvetteDesignAntiFrigate, 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }


                                for(int k=0;k<3;k++)
                                {
                                    float x0=12000.0f*tw_rnd(randBuf,i)-6000.0f;
                                    float y0=6000.0f*tw_rnd(randBuf,i)+500.0f;
                                    createShipAtScreenCenter(newShipCreateId++,teamBlue, true, -100.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,true, cruiserDesignAntiCruiser, 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }
                                for(int k=0;k<12;k++)
                                {
                                    float x0=12000.0f*tw_rnd(randBuf,i)-6000.0f;
                                    float y0=6000.0f*tw_rnd(randBuf,i)+500.0f;
                                    createShipAtScreenCenter(newShipCreateId++,teamBlue, true, -100.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,true,destroyerDesignAntiCruiser , 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }

                                for(int k=0;k<20;k++)
                                {
                                    float x0=12000.0f*tw_rnd(randBuf,i)-6000.0f;
                                    float y0=6000.0f*tw_rnd(randBuf,i)+500.0f;
                                    createShipAtScreenCenter(newShipCreateId++,teamBlue, true, -100.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,true,heavyFrigateDesignAntiCorvette , 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }
                                for(int k=0;k<50;k++)
                                {
                                    float x0=12000.0f*tw_rnd(randBuf,i)-6000.0f;
                                    float y0=6000.0f*tw_rnd(randBuf,i)+500.0f;
                                    createShipAtScreenCenter(newShipCreateId++,teamBlue, true, -100.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,true, heavyCorvetteDesignAntiFrigate, 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }

                                waitForTimeSpan(20000.0f, &adr, command, commandData);
                                for(int k=0;k<10;k++)
                                {
                                    float x0=3000.0f*tw_rnd(randBuf,i);
                                    float y0=14000.0f*tw_rnd(randBuf,i);
                                    createShipAtScreenCenter(newShipCreateId++,teamRed, true, -10.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,false, cruiserDesignAntiCruiser, 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }

                                for(int k=0;k<20;k++)
                                {
                                    float x0=3000.0f*tw_rnd(randBuf,i);
                                    float y0=14000.0f*tw_rnd(randBuf,i);
                                    createShipAtScreenCenter(newShipCreateId++,teamRed, true, -10.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,false,destroyerDesignAntiCruiser , 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }

                                for(int k=0;k<40;k++)
                                {
                                    float x0=3000.0f*tw_rnd(randBuf,i);
                                    float y0=14000.0f*tw_rnd(randBuf,i);
                                    createShipAtScreenCenter(newShipCreateId++,teamRed, true, -10.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,false, heavyFrigateDesignAntiCorvette, 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }

                                for(int k=0;k<80;k++)
                                {
                                    float x0=3000.0f*tw_rnd(randBuf,i);
                                    float y0=14000.0f*tw_rnd(randBuf,i);
                                    createShipAtScreenCenter(newShipCreateId++,teamRed, true, -10.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,false, heavyCorvetteDesignAntiFrigate, 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }

                                waitForTimeSpan(30000.0f, &adr, command, commandData);

                                for(int k=0;k<10;k++)
                                {
                                    float x0=14000-3000.0f*tw_rnd(randBuf,i);
                                    float y0=14000.0f*tw_rnd(randBuf,i);
                                    createShipAtScreenCenter(newShipCreateId++,teamRed, true, 170.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,false, cruiserDesignAntiCruiser, 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }

                                for(int k=0;k<20;k++)
                                {
                                    float x0=14000-3000.0f*tw_rnd(randBuf,i);
                                    float y0=14000.0f*tw_rnd(randBuf,i);
                                    createShipAtScreenCenter(newShipCreateId++,teamRed, true, 170.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,false,destroyerDesignAntiCruiser , 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }

                                for(int k=0;k<40;k++)
                                {
                                    float x0=14000-3000.0f*tw_rnd(randBuf,i);
                                    float y0=14000.0f*tw_rnd(randBuf,i);
                                    createShipAtScreenCenter(newShipCreateId++,teamRed, true, 170.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,false, heavyFrigateDesignAntiCorvette, 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }

                                for(int k=0;k<80;k++)
                                {
                                    float x0=14000-3000.0f*tw_rnd(randBuf,i);
                                    float y0=14000.0f*tw_rnd(randBuf,i);
                                    createShipAtScreenCenter(newShipCreateId++,teamRed, true, 170.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,false, heavyCorvetteDesignAntiFrigate, 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }
                            }
                            else if(j==0)
                            {
                                // camera move side
                                lockCameraToShipForTimeSpan(newShipCreateId-1, 4000.0f, &adr, command, commandData);
                                moveCameraToShipAnimated(newShipCreateId,1000.0f, &adr,&dataAdr, command, commandData, dataInt, dataFloat);
                                lockCameraToShipForTimeSpan(newShipCreateId, 2000.0f, &adr, command, commandData);
                                moveCameraToShipAnimated(newShipCreateId-1,1000.0f, &adr,&dataAdr, command, commandData, dataInt, dataFloat);
                                disableMousePointer(&adr, command);  
                                lockCameraToShipForTimeSpan(newShipCreateId-1, 25000.0f, &adr, command, commandData);
                                for(int k=0;k<4800;k++)
                                {
                                    warpCameraAtTime(33000+3*k, 0+k*3 , MAP_HEIGHT/2 - 200, &adr, command,  commandData);
                                }

                                for(int k=0;k<9600;k++)
                                {
                                    warpCameraAtTime(33000+3*4800+4*k, 4800*3-k*1 , MAP_HEIGHT/2 - 200, &adr, command,  commandData);
                                }

                                for(int k=0;k<9600;k++)
                                {
                                    warpCameraAtTime(8000+33000+3*4800+4*9600+k*4, 4800*3-9600*1+k*1 , MAP_HEIGHT/2 - 200, &adr, command,  commandData);
                                }
                            }
                            if(j==1)
                            {
                                // camera zoom
                                int time0=19000;
                                for(int k=0;k<200;k++)
                                    zoomCameraAtTime(time0+=3,1.0f-k*0.0022f, &adr, command, commandData);
                                time0+=6000;
                                for(int k=0;k<200;k++)
                                    zoomCameraAtTime(time0+=5,1.0f-200*0.0022f+k*0.007f, &adr, command, commandData);
                                time0+=5000;
                                for(int k=0;k<300;k++)
                                    zoomCameraAtTime(time0+=5,1.0f-200*0.0022f+200*0.007f+k*0.05f, &adr, command, commandData);
                                time0+=3000;
                                for(int k=0;k<300;k++)
                                    zoomCameraAtTime(time0+=5,1.0f-200*0.0022f+200*0.007f+300*0.05f-k*0.05f, &adr, command, commandData);
                                time0=45000;
                                for(int k=0;k<200;k++)
                                    zoomCameraAtTime(time0+=5,1.0f-200*0.0022f+200*0.007f+300*0.05f-300*0.05f-k*0.004f, &adr, command, commandData);

                                
                            }
                            else if(j==104)
                            {
         

                            }
                        });


                    }
                }
            }



            // recalculate a newly created ship's module info(and ship stats)
            // i: ship id
            void shipModuleRecalculate(int i, __global uchar * shipModuleType,
                                       __global int * shipModuleEnergy,
                                       __global int * shipModuleEnergyMax,
                                       __global uchar * shipModuleHP,
                                       __global uchar * shipModuleHPMax,
                                       __global uchar * shipModuleState,
                                       __global int * shipModuleWeight,
                                       __global int * shipShield,
                                       __global int * shipShieldMax,
                                       __global uint * randBuf,
                                       __global uchar * shipState,  
                                       bool moving)
            {
                
                mem_fence(CLK_GLOBAL_MEM_FENCE);
                if(moving)
                    shipState[i]|=PROJECTILE_FORWARD;
                else
                    shipState[i]&=~PROJECTILE_FORWARD;
	            for(int j=0;j<MAX_MODULES_PER_SHIP;j++)
	            { 
		            if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_CANNON_TURRET)
		            {
		 	            shipModuleEnergy[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_ENERGY; 
		 	            shipModuleEnergyMax[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_ENERGY; 
		 	            int hp=d8(randBuf,i);
			            shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			            shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			            shipModuleWeight[i + N_SHIP_MAX*j]=5; // 50 ton 
		            }
		            else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_CANNON_TURRET_FRIGATE)
		            {
		 	            shipModuleEnergy[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_ENERGY_FRIGATE; 
		 	            shipModuleEnergyMax[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_ENERGY_FRIGATE; 
		 	            int hp=3+d12(randBuf,i);
			            shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			            shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			            shipModuleWeight[i + N_SHIP_MAX*j]=12; // 120 ton 
		            }
		            else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_CANNON_TURRET_DESTROYER)
		            {
		 	            shipModuleEnergy[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_ENERGY_DESTROYER; 
		 	            shipModuleEnergyMax[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_ENERGY_DESTROYER; 
		 	            int hp=5+d20(randBuf,i);
			            shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			            shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			            shipModuleWeight[i + N_SHIP_MAX*j]=30; // 300 ton 
		            }
		            else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_CANNON_TURRET_CRUISER)
		            {
		 	            shipModuleEnergy[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_ENERGY_CRUISER; 
		 	            shipModuleEnergyMax[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_ENERGY_CRUISER; 
		 	            int hp=15+d20(randBuf,i)+d20(randBuf,i);
			            shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			            shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			            shipModuleWeight[i + N_SHIP_MAX*j]=100; // 1000 ton 
		            }
		            else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_CANNON_TURRET_TURBO)
		            {
		 	            shipModuleEnergy[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY; 
		 	            shipModuleEnergyMax[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY; 
		 	            int hp=d8(randBuf,i);
			            shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			            shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			            shipModuleWeight[i + N_SHIP_MAX*j]=5; // 50 ton 
		            }
		            else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_FRIGATE)
		            {
		 	            shipModuleEnergy[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_FRIGATE; 
		 	            shipModuleEnergyMax[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_FRIGATE; 
		 	            int hp=3+d12(randBuf,i);
			            shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			            shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			            shipModuleWeight[i + N_SHIP_MAX*j]=12; // 120 ton 
		            }
		            else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_DESTROYER)
		            {
		 	            shipModuleEnergy[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_DESTROYER; 
		 	            shipModuleEnergyMax[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_DESTROYER; 
		 	            int hp=5+d20(randBuf,i);
			            shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			            shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			            shipModuleWeight[i + N_SHIP_MAX*j]=30; // 300 ton 
		            }
		            else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_CRUISER)
		            {
		 	            shipModuleEnergy[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_CRUISER; 
		 	            shipModuleEnergyMax[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_CRUISER; 
		 	            int hp=15+d20(randBuf,i)+d20(randBuf,i);
			            shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			            shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			            shipModuleWeight[i + N_SHIP_MAX*j]=100; // 1000 ton 
		            }
		            else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_POWER_SOURCE)
		            { 	
			            shipModuleEnergy[i + N_SHIP_MAX*j]=1;
			            shipModuleEnergyMax[i + N_SHIP_MAX*j]=1;
		 	            int hp=d4(randBuf,i);
			            shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			            shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			            shipModuleWeight[i + N_SHIP_MAX*j]=8;  
		            } 
		            else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_POWER_SOURCE_FRIGATE)
		            { 	
			            shipModuleEnergy[i + N_SHIP_MAX*j]=5;
			            shipModuleEnergyMax[i + N_SHIP_MAX*j]=5;
		 	            int hp=5+d6(randBuf,i);
			            shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			            shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			            shipModuleWeight[i + N_SHIP_MAX*j]=20;  
		            } 
		            else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_POWER_SOURCE_DESTROYER)
		            { 	
			            shipModuleEnergy[i + N_SHIP_MAX*j]=20;
			            shipModuleEnergyMax[i + N_SHIP_MAX*j]=20;
		 	            int hp=15+d20(randBuf,i);
			            shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			            shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			            shipModuleWeight[i + N_SHIP_MAX*j]=50;  
		            }
		            else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_POWER_SOURCE_CRUISER)
		            { 	
			            shipModuleEnergy[i + N_SHIP_MAX*j]=100;
			            shipModuleEnergyMax[i + N_SHIP_MAX*j]=100;
		 	            int hp=25+d20(randBuf,i)+d20(randBuf,i);
			            shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			            shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			            shipModuleWeight[i + N_SHIP_MAX*j]=150;  
		            }
		            else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_SHIELD_GENERATOR)
		            { 	
			            shipModuleEnergy[i + N_SHIP_MAX*j]=SHIP_MODULE_SHIELD_GENERATOR_ENERGY;
			            shipModuleEnergyMax[i + N_SHIP_MAX*j]=SHIP_MODULE_SHIELD_GENERATOR_ENERGY; 
		 	            int hp=d4(randBuf,i);
			            shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			            shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			            shipModuleWeight[i + N_SHIP_MAX*j]=50;  
		            }
		            else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_SHIELD_GENERATOR_FRIGATE)
		            { 	
			            shipModuleEnergy[i + N_SHIP_MAX*j]=SHIP_MODULE_SHIELD_GENERATOR_ENERGY_FRIGATE;
			            shipModuleEnergyMax[i + N_SHIP_MAX*j]=SHIP_MODULE_SHIELD_GENERATOR_ENERGY_FRIGATE; 
		 	            int hp=2+d4(randBuf,i);
			            shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			            shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			            shipModuleWeight[i + N_SHIP_MAX*j]=90;  
		            }
		            else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_SHIELD_GENERATOR_DESTROYER)
		            { 	
			            shipModuleEnergy[i + N_SHIP_MAX*j]=SHIP_MODULE_SHIELD_GENERATOR_ENERGY_DESTROYER;
			            shipModuleEnergyMax[i + N_SHIP_MAX*j]=SHIP_MODULE_SHIELD_GENERATOR_ENERGY_DESTROYER; 
		 	            int hp=5+d10(randBuf,i);
			            shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			            shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			            shipModuleWeight[i + N_SHIP_MAX*j]=290;  
		            }
		            else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_SHIELD_GENERATOR_CRUISER)
		            { 	
			            shipModuleEnergy[i + N_SHIP_MAX*j]=SHIP_MODULE_SHIELD_GENERATOR_ENERGY_CRUISER;
			            shipModuleEnergyMax[i + N_SHIP_MAX*j]=SHIP_MODULE_SHIELD_GENERATOR_ENERGY_CRUISER; 
		 	            int hp=15+d10(randBuf,i)+d10(randBuf,i);
			            shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			            shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			            shipModuleWeight[i + N_SHIP_MAX*j]=290;  
		            }
		            else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_ENERGY_CAPACITOR)
		            { 	
			            shipModuleEnergy[i + N_SHIP_MAX*j]=100;
			            shipModuleEnergyMax[i + N_SHIP_MAX*j]=100;
		 	            int hp=d6(randBuf,i);
			            shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			            shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			            shipModuleWeight[i + N_SHIP_MAX*j]=10;  
		            }
		            else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_ENERGY_CAPACITOR_FRIGATE)
		            { 	
			            shipModuleEnergy[i + N_SHIP_MAX*j]=250;
			            shipModuleEnergyMax[i + N_SHIP_MAX*j]=250;
		 	            int hp=5+d6(randBuf,i);
			            shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			            shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			            shipModuleWeight[i + N_SHIP_MAX*j]=30;  
		            }
		            else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_ENERGY_CAPACITOR_DESTROYER)
		            { 	
			            shipModuleEnergy[i + N_SHIP_MAX*j]=700;
			            shipModuleEnergyMax[i + N_SHIP_MAX*j]=700;
		 	            int hp=15+d20(randBuf,i);
			            shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			            shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			            shipModuleWeight[i + N_SHIP_MAX*j]=100;  
		            }
		            else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_ENERGY_CAPACITOR_CRUISER)
		            { 	
			            shipModuleEnergy[i + N_SHIP_MAX*j]=2000;
			            shipModuleEnergyMax[i + N_SHIP_MAX*j]=2000;
		 	            int hp=25+d20(randBuf,i)+d20(randBuf,i);
			            shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			            shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			            shipModuleWeight[i + N_SHIP_MAX*j]=300;  
		            }
	            }

	            mem_fence(CLK_GLOBAL_MEM_FENCE);

	            int tmpShield = 0;
	            for(int im=0;im<MAX_MODULES_PER_SHIP;im++)
	            { 
		            // get number of shield generators
		            if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_SHIELD_GENERATOR)
		            { 
			            if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
			            { 
				            tmpShield+=16;
			            }
		            }
		            else
		            if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_SHIELD_GENERATOR_FRIGATE)
		            { 
			            if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
			            { 
				            tmpShield+=32;
			            }
		            }
		            else
		            if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_SHIELD_GENERATOR_DESTROYER)
		            { 
			            if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
			            { 
				            tmpShield+=48;
			            }
		            }
		            else
		            if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_SHIELD_GENERATOR_CRUISER)
		            { 
			            if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
			            { 
				            tmpShield+=64;
			            }
		            }
	            }

	            shipShield[i]=tmpShield;
	            shipShieldMax[i]=tmpShield;

            }


            void calculateShipHp(int threadId, int shipId, uchar shipSizeType, __global int * shipHp, 
                                __global int * shipHpMax, __global uint * randSeeds)
            {
	            int nDice=0;
	            int total=0;
	            if(shipSizeType==SHIP_SIZE_TYPE_CORVETTE)
	            { 
		            nDice=7;
		            for(int id=0; id<nDice;id++ )
			            total+=d4(randSeeds,threadId);
	            }
	            else if(shipSizeType==SHIP_SIZE_TYPE_FRIGATE)
	            { 
		            nDice=10;
		            for(int id=0; id<nDice;id++ )
			            total+=d6(randSeeds,threadId);
	            }
	            else if(shipSizeType==SHIP_SIZE_TYPE_DESTROYER)
	            { 
		            nDice=15;
		            for(int id=0; id<nDice;id++ )
			            total+=d8(randSeeds,threadId);
	            }
	            else if(shipSizeType==SHIP_SIZE_TYPE_CRUISER)
	            { 
		            nDice=20;
		            for(int id=0; id<nDice;id++ )
			            total+=d10(randSeeds,threadId);
	            }
	            shipHp[shipId]=total;
	            shipHpMax[shipId]=total;
            }

            // script engine for benchmark + game control
            // control ships, camera, postprocessing
            // N_SCRIPT_WORKER workitems for running, 0th workitem for control
            __kernel void scriptEngine( __global int * command,    
                                        __global float * commandData,
                                        __global int * commandPointer,
                                        __global int * engineState,
                                        __global int * intUserParameters,
                                        __global float * floatUserParameters,
                                        __global float * frameTime,
                                        __global float * frameTimeInner,
                                        __global float * shipX,
                                        __global float * shipY,
                                        __global int * dataInt,
                                        __global float * shipXOld,
                                        __global float * shipYOld,
                                        __global float * dataFloat,
                                        __global uchar * shipTeam,
                                        __global uchar * shipSizeType,
                                        __global uchar * shipModuleType,
                                       __global int * shipModuleEnergy,
                                       __global int * shipModuleEnergyMax,
                                       __global uchar * shipModuleHP,
                                       __global uchar * shipModuleHPMax,
                                       __global uchar * shipModuleState,
                                       __global int * shipModuleWeight,
                                       __global int * shipShield,
                                       __global int * shipShieldMax,
                                       __global uint * randBuf,
                                       __global uchar * shipState,
                                       __global float * shipRotation,
                                       __global int * shipHp,
                                       __global int * shipHpMax,        
                                       __global float * shipTargetX,
                                       __global float * shipTargetY,
                                       __global int * shipSelected,
                                       __global int * shipTargetShip
                                        )
            {
                int id=get_global_id(0);
                for(int rep=0;rep<100;rep++)
                {
  
                    int frameCount=engineState[ENGINE_STATE_FRAME_COUNT];
                    float totalTimeMs = frameTime[TIME_TOTAL_ELAPSED];
                    float checkpointTimeMs = frameTimeInner[TIME_CHECKPOINT+ENGINE_STATE_PER_THREAD*id];
                    int pointer = commandPointer[id];
                    int workerActive = engineState[ENGINE_STATE_WORKER_ACTIVE + ENGINE_STATE_PER_THREAD*id];
                    int workerJumpSize = engineState[ENGINE_STATE_WORKER_JUMP_SIZE + ENGINE_STATE_PER_THREAD*id];
                    int workerRunningCount=engineState[ENGINE_STATE_WORKER_RUNNING_COUNT];
                    
                    int workerStepSize=1;



                    barrier(CLK_GLOBAL_MEM_FENCE);
                    
                    if(command[pointer]==COMMAND_BIND_WORKER)                   
                    {
                        int workerId=(int)commandData[COMMAND_PARAMETER_0(pointer)];
                        if(id==0)
                        {
                            engineState[ENGINE_STATE_WORKER_JUMP_SIZE + ENGINE_STATE_PER_THREAD*workerId]= 
                                ((N_SCRIPT_WORKER-1) * (int)commandData[COMMAND_PARAMETER_1(pointer)]) - ((int)commandData[COMMAND_PARAMETER_1(pointer)] - 1);
                            // if worker is not bound already
                            // (it will get there itself)
                            if(engineState[ENGINE_STATE_WORKER_ACTIVE + ENGINE_STATE_PER_THREAD*workerId]==0)
                            {
                                commandPointer[workerId]=pointer+1;
                                engineState[ENGINE_STATE_WORKER_ACTIVE + ENGINE_STATE_PER_THREAD*workerId]=1;
                            }
                            else
                            {
                                // increase number of jumps so worker will jump here when finished
                                // jump size = N_SCRIPT_WORKER - 1 * step size
                                engineState[ENGINE_STATE_WORKER_NUM_JUMPS_LEFT + ENGINE_STATE_PER_THREAD*workerId]++;
                            }
                            commandPointer[id]+=(int)commandData[COMMAND_PARAMETER_1(pointer)];
                            engineState[ENGINE_STATE_WORKER_RUNNING_COUNT]++;
                        }
                        else
                        {

                        }
                    }

                    barrier(CLK_GLOBAL_MEM_FENCE);

                    if(workerActive && (command[pointer]==COMMAND_STOP_WORKER))
                    {
                        // id==0 must not get this command
                        // check if num jumps left is > 0
                        // then jump for N_SCRIPT_WORKER - 1 * step size commands
                        if(engineState[ENGINE_STATE_WORKER_NUM_JUMPS_LEFT + ENGINE_STATE_PER_THREAD*id]>0)
                        {
                            commandPointer[id]+=workerJumpSize;
                            engineState[ENGINE_STATE_WORKER_NUM_JUMPS_LEFT + ENGINE_STATE_PER_THREAD*id]--;
                        }
                        else
                        {
                            engineState[ENGINE_STATE_WORKER_ACTIVE + ENGINE_STATE_PER_THREAD*id]=0;
                            commandPointer[id]=0;
                        }     
                        atomic_add(&engineState[ENGINE_STATE_WORKER_RUNNING_COUNT],-1);          
                    }

                    barrier(CLK_GLOBAL_MEM_FENCE);

                    if((id==0) || workerActive)
                    {
                        if(command[pointer]==COMMAND_MOVE_CAMERA_TO_SHIP_ANIMATED)   
                        {
                            // move camera to ship until it is close enough
                            int dataId=(int)commandData[COMMAND_PARAMETER_0(pointer)];
                            int shipId=dataInt[dataId++];       
                            float totalTimeForAnimation=dataFloat[dataId++];
                            float currentTimeForAnimation=dataFloat[dataId];


                            if(checkpointTimeMs<0.01f)
                            {
                                // animation started
                                frameTimeInner[TIME_CHECKPOINT+ENGINE_STATE_PER_THREAD*id]=totalTimeMs;
                                dataFloat[dataId+1]=floatUserParameters[USER_VAR_MAP_X];
                                dataFloat[dataId+2]=floatUserParameters[USER_VAR_MAP_Y];
                            }
                            else
                            if(totalTimeMs-checkpointTimeMs>=totalTimeForAnimation)
                            {
                                // animation complete
                                frameTimeInner[TIME_CHECKPOINT+ENGINE_STATE_PER_THREAD*id]=0.0f;
                                pointer+=workerStepSize;
                                commandPointer[id]=pointer;
                            }
                            else
                            {
                                if(currentTimeForAnimation<totalTimeMs-checkpointTimeMs)
                                {
                                    dataFloat[dataId]=totalTimeMs-checkpointTimeMs; 
                                    float animationRatio=(totalTimeMs-checkpointTimeMs)/totalTimeForAnimation;
                                    animationRatio=sin(animationRatio*3.14f/2.0f);
                                    // move camera to point lying between current cam pos and ship pos
                                    floatUserParameters[USER_VAR_MAP_X]=(shipX[shipId]*animationRatio+dataFloat[dataId+1]*(1.0f-animationRatio));
                                    floatUserParameters[USER_VAR_MAP_Y]=(shipY[shipId]*animationRatio+dataFloat[dataId+2]*(1.0f-animationRatio));
                                }
                            }
                        }
                        else if(command[pointer]==COMMAND_SET_SHIP_MOVE_TARGET)
                        {
                            // set ship target location x,y from data
                            int dataId=(int)commandData[COMMAND_PARAMETER_0(pointer)];
                            int shipId=dataInt[dataId++];
                            float targetX=dataFloat[dataId++];
                            float targetY=dataFloat[dataId++];
                            // set ship target
                            shipTargetX[shipId]=targetX;
                            shipTargetY[shipId]=targetY;
                            shipSelected[shipId]=-1; // script selected
                            pointer+=workerStepSize;
                            commandPointer[id]=pointer;
                        }
                        else if(command[pointer]==COMMAND_SET_SHIP_SHIP_TARGET)
                        {
                            // set ship target location x,y from data
                            int dataId=(int)commandData[COMMAND_PARAMETER_0(pointer)];
                            int shipId=dataInt[dataId++];
                            int targetShipId=dataInt[dataId++];
                            shipTargetShip[shipId]=targetShipId;
                            shipSelected[shipId]=-1; // script selected
                            pointer+=workerStepSize;
                            commandPointer[id]=pointer;
                        }
                        else if(command[pointer]==COMMAND_SYNC_WORKER)
                        {
                            // wait for workers completion
                            if(workerRunningCount==0)
                            {
                                commandPointer[id]++;
                            }
                            else
                            {
                                // wait for completion
                            }
                        }
                        else if(command[pointer]==COMMAND_WARP_CAMERA)
                        {
                            // set pointer to next command
                            // do instant camera movement
                            floatUserParameters[USER_VAR_MAP_X]=
                                commandData[COMMAND_PARAMETER_0(pointer)];
                            floatUserParameters[USER_VAR_MAP_Y]=
                                commandData[COMMAND_PARAMETER_1(pointer)];
                            pointer+=workerStepSize;
                            commandPointer[id]=pointer;
                        }
                        else if(command[pointer]==COMMAND_ZOOM_CAMERA)
                        {
                            // set pointer to next command
                            // do instant camera zoom
                            floatUserParameters[USER_VAR_MAP_SCALE]=
                                commandData[COMMAND_PARAMETER_0(pointer)];
                            pointer+=workerStepSize;
                            commandPointer[id]=pointer;

                        }
                        else if(command[pointer]==COMMAND_LOCK_CAMERA_TO_SHIP)
                        {
                            floatUserParameters[USER_VAR_MAP_X]=
                                shipX[(int)floor(commandData[COMMAND_PARAMETER_0(pointer)] + 0.1f)];
                            floatUserParameters[USER_VAR_MAP_Y]=
                                shipY[(int)floor(commandData[COMMAND_PARAMETER_0(pointer)]+0.1f)];

                            // wait for miliseconds
                            // set pointer to next command when complete
                            if(checkpointTimeMs<0.01f)
                            {
                                frameTimeInner[TIME_CHECKPOINT+ENGINE_STATE_PER_THREAD*id]=totalTimeMs;
                            }
                            else
                            if(totalTimeMs-checkpointTimeMs>=commandData[COMMAND_PARAMETER_1(pointer)])
                            {
                                frameTimeInner[TIME_CHECKPOINT+ENGINE_STATE_PER_THREAD*id]=0.0f;
                                pointer+=workerStepSize;
                                commandPointer[id]=pointer;
                            }
                        }
                        else if(command[pointer]==COMMAND_MOVE_SHIP)
                        {
                            int dataId=(int)floor(commandData[COMMAND_PARAMETER_0(pointer)]+0.1f);
                            int newShipId=dataInt[dataId];
                            float newShipX=dataFloat[dataId+1];
                            float newShipY=dataFloat[dataId+2];

                            // if x,y negative, get to camera position (screen center) 
                            // set old position too, for verlet integrator
                            if((newShipX<0.5f) && (newShipY<0.5f))
                            {
                                float newShipTranslationX=dataFloat[dataId+3];
                                float newShipTranslationY=dataFloat[dataId+4];
                                shipX[newShipId]   =floatUserParameters[USER_VAR_MAP_X] + newShipTranslationX;
                                shipXOld[newShipId]=floatUserParameters[USER_VAR_MAP_X] + newShipTranslationX;
                                shipY[newShipId]   =floatUserParameters[USER_VAR_MAP_Y] + newShipTranslationY;                              
                                shipYOld[newShipId]=floatUserParameters[USER_VAR_MAP_Y] + newShipTranslationY;                              
                            }
                            else
                            {
                                shipX[newShipId]=newShipX;
                                shipXOld[newShipId]=newShipX;
                                shipY[newShipId]=newShipY;
                                shipYOld[newShipId]=newShipY;
                            }   
                            bool moving=dataInt[dataId+5];
                            if(moving)
                            {
                                shipState[newShipId]|=PROJECTILE_FORWARD;
                            }
                            else
                            {
                                shipState[newShipId]&=~PROJECTILE_FORWARD;
                            }
                            // if angle is not over critical range (this means only translation, no rotation)
                            if(dataFloat[dataId+6]<999999990.0f)
                                shipRotation[newShipId]=dataFloat[dataId+6];
                            pointer+=workerStepSize;
                            commandPointer[id]=pointer;
                        }
                        else if(command[pointer]==COMMAND_DISABLE_MOUSE_POINTER)
                        {
                            // send mouse pointer to infinity
                            // set pointer to next command
                            floatUserParameters[USER_VAR_MOUSE_X]=-50000.0f;
                            floatUserParameters[USER_VAR_MOUSE_Y]=-50000.0f;

                            pointer+=workerStepSize;
                            commandPointer[id]=pointer;
                        }
                        else if(command[pointer]==COMMAND_ENABLE_MOUSE_POINTER)
                        {
                            floatUserParameters[USER_VAR_MOUSE_X]=RENDER_WIDTH/2.0f;
                            floatUserParameters[USER_VAR_MOUSE_Y]=RENDER_HEIGHT/2.0f;

                            pointer+=workerStepSize;
                            commandPointer[id]=pointer;
                        }
                        else if(command[pointer]==COMMAND_ENABLE_HARDPOINT_VIEW)
                        {
                            intUserParameters[USER_VAR_HARDPOINT_VIEW]=1;
                            pointer+=workerStepSize;
                            commandPointer[id]=pointer;
                        }
                        else if(command[pointer]==COMMAND_ENABLE_CAPTAIN_EXPERIENCE_VIEW)
                        {
                            intUserParameters[USER_VAR_CAPTAIN_EXPERIENCE_VIEW]=1;
                            pointer+=workerStepSize;
                            commandPointer[id]=pointer;
                        }
                        else if(command[pointer]==COMMAND_MOVE_ALL_SHIPS_OUT)
                        {
                            // send all ships to negative infinity
                            // todo: make this offloadable to threads 0-255 in async
                            // for now, 110ms with R7-240
                            for(int ship=0;ship<N_SHIP_MAX;ship++)
                            {    
                                shipX[ship]=-999999999.0f;
                                shipY[ship]=-999999999.0f;
                                shipXOld[ship]=-999999999.0f;
                                shipYOld[ship]=-999999999.0f;
                            }
                            pointer+=workerStepSize;
                            commandPointer[id]=pointer;

                            
                        }
                        else if(command[pointer]==COMMAND_CREATE_SHIP_BY_DATA)
                        {
                            int dataId=(int)floor(commandData[COMMAND_PARAMETER_0(pointer)]+0.1f);
                            int newShipId=dataInt[dataId];
                            float newShipX=dataFloat[dataId+1];
                            float newShipY=dataFloat[dataId+2];

                            // if x,y negative, get to camera position (screen center) 
                            // set old position too, for verlet integrator
                            if((newShipX<0.5f) && (newShipY<0.5f))
                            {
                                float newShipTranslationX=dataFloat[dataId+3];
                                float newShipTranslationY=dataFloat[dataId+4];
                                shipX[newShipId]   =floatUserParameters[USER_VAR_MAP_X] + newShipTranslationX;
                                shipXOld[newShipId]=floatUserParameters[USER_VAR_MAP_X] + newShipTranslationX;
                                shipY[newShipId]   =floatUserParameters[USER_VAR_MAP_Y] + newShipTranslationY;                              
                                shipYOld[newShipId]=floatUserParameters[USER_VAR_MAP_Y] + newShipTranslationY;                              
                            }
                            else
                            {
                                shipX[newShipId]=newShipX;
                                shipXOld[newShipId]=newShipX;
                                shipY[newShipId]=newShipY;
                                shipYOld[newShipId]=newShipY;
                            }
    
                            shipTeam[newShipId]=dataInt[dataId+5];
                            shipSizeType[newShipId]=dataInt[dataId+6];
                            shipModuleType[newShipId]=dataInt[dataId+7];
                            shipModuleType[newShipId+N_SHIP_MAX]=dataInt[dataId+8];
                            shipModuleType[newShipId+N_SHIP_MAX*2]=dataInt[dataId+9];
                            shipModuleType[newShipId+N_SHIP_MAX*3]=dataInt[dataId+10];
                            shipModuleType[newShipId+N_SHIP_MAX*4]=dataInt[dataId+11];
                            shipModuleType[newShipId+N_SHIP_MAX*5]=dataInt[dataId+12];
                            shipModuleType[newShipId+N_SHIP_MAX*6]=dataInt[dataId+13];
                            shipModuleType[newShipId+N_SHIP_MAX*7]=dataInt[dataId+14];
                            shipModuleType[newShipId+N_SHIP_MAX*8]=dataInt[dataId+15];
                            shipModuleType[newShipId+N_SHIP_MAX*9]=dataInt[dataId+16];
                            bool moving=dataInt[dataId+17];
                            shipRotation[newShipId]=dataFloat[dataId+18];
                            shipModuleRecalculate(  newShipId, shipModuleType,
                                                    shipModuleEnergy,shipModuleEnergyMax, shipModuleHP, 
                                                    shipModuleHPMax, shipModuleState, shipModuleWeight,
                                                    shipShield, shipShieldMax, randBuf,shipState,moving);
                            calculateShipHp(        id, newShipId, dataInt[dataId+6],shipHp, 
                                                    shipHpMax, randBuf);
                            pointer+=workerStepSize;
                            commandPointer[id]=pointer;

                           
                        }
                        else if(command[pointer]==COMMAND_WAIT_MS)
                        {
                            // wait for miliseconds
                            // set pointer to next command when complete
                            if(checkpointTimeMs<0.01f)
                            {
                                frameTimeInner[TIME_CHECKPOINT+ENGINE_STATE_PER_THREAD*id]=totalTimeMs;
                            }
                            else
                            if(totalTimeMs-checkpointTimeMs>=commandData[COMMAND_PARAMETER_0(pointer)])
                            {
                                frameTimeInner[TIME_CHECKPOINT+ENGINE_STATE_PER_THREAD*id]=0.0f;
                                pointer+=workerStepSize;
                                commandPointer[id]=pointer;

                            }
                        }
                        else if(command[pointer]==COMMAND_WAIT_FOR_FRAME)
                        {
                            if(frameCount>=commandData[COMMAND_PARAMETER_0(pointer)])
                            {
                                pointer+=workerStepSize;
                                commandPointer[id]=pointer;

                               
                            }
                            else
                            {
                            }
                        }
                        else if(command[pointer]==COMMAND_WAIT_FOR_TOTAL_TIME)
                        {
                            if(totalTimeMs>=commandData[COMMAND_PARAMETER_0(pointer)])
                            {
                                pointer+=workerStepSize;
                                commandPointer[id]=pointer;

                               
                            }
                            else
                            {
                            }
                        }

                    }

                    barrier(CLK_GLOBAL_MEM_FENCE);

                }
            }









// test test
// test test
// test test
// test test
// test test
// test test
// test test
// test test
// test test
// test test
// test test
// test test
// test test
// test test
// test test
// test test
// test test
// test test
// test test
// test test
// test test







        ";


        ClArray<int> scriptEngineState { get; set; }

        ClArray<int> benchmarkIntParameters { get; set; }
        ClArray<float> benchmarkFloatParameters { get; set; }
        ClTask benchmarkStep { get; set; }
        ClTask benchmarkScriptSetup { get; set; }

        ClArray<float> frameTime { get; set; }
        ClArray<float> frameTimeInner { get; set; }
        ClArray<int> scriptCommand { get; set; }
        ClArray<float> scriptCommandParameter { get; set; }
        ClArray<int> scriptCommandPointer { get; set; }
        ClArray<int> dataInt { get; set; }
        ClArray<float> dataFloat { get; set; }
        ClTask scriptEngine { get; set; }

        ClArray<float> benchmarkShipX { get; set; }
        ClArray<float> benchmarkShipXOld { get; set; }
        ClArray<float> benchmarkShipY { get; set; }
        ClArray<float> benchmarkShipYOld { get; set; }
        ClArray<byte> benchmarkShipTeam { get; set; }
        ClArray<byte> benchmarkShipSizeType { get; set; }
        ClArray<byte> benchmarkShipModuleType { get; set; }
        ClArray<int> benchmarkShipModuleEnergy { get; set; }
        ClArray<int> benchmarkShipModuleEnergyMax { get; set; }
        ClArray<byte> benchmarkShipModuleHP { get; set; }
        ClArray<byte> benchmarkShipModuleHPMax { get; set; }
        ClArray<byte> benchmarkShipModuleState { get; set; }

        ClArray<int> benchmarkShipModuleWeight { get; set; }
        ClArray<int> benchmarkShipShield { get; set; }
        ClArray<int> benchmarkShipShieldMax { get; set; }
        ClArray<int> benchmarkRandBuf { get; set; }

        ClArray<byte> benchmarkShipState { get; set; }
        ClArray<float> benchmarkShipRotation { get; set; }
        ClArray<int> benchmarkShipHp { get; set; }
        ClArray<int> benchmarkShipHpMax { get; set; }
        ClArray<float> benchmarkShipTargetX { get; set; }
        ClArray<float> benchmarkShipTargetY { get; set; }
        ClArray<int> benchmarkShipSelected { get; set; }
        ClArray<int> benchmarkShipTargetShip { get; set; } // todo


        string replaceUid(string s)
        {
            StringBuilder sb = new StringBuilder();
            int l = s.Length;
            int uidCtr = 0;
            for(int i=0;i<l;i++)
            {
                if (i < l - 7)
                {
                    if (s.Substring(i, 7).Equals("@@uid@@"))
                    {
                        sb.Append(uidCtr.ToString());
                        i += 6;
                        uidCtr--;
                    }
                    else
                    {
                        sb.Append(s[i]);
                    }
                }
                else
                {
                    sb.Append(s[i]);
                }
            }
            //Console.WriteLine(sb.ToString().Substring(0,2500));
            return sb.ToString();
        }

        int windowStartWidth = 0;
        int windowStartHeight = 0;
        bool benchModeSelected = false;
        object benchTimeSync = new object();
        const int scriptWorkerN = 256;
        private void benchmark720p_Click(object sender, EventArgs e)
        {
            // counting for #define lines
            benchmarkKernels = replaceUid(benchmarkKernels).Replace("@@scriptWorkerN@@", scriptWorkerN.ToString());
            lock (benchTimeSync)
            {
                benchmarkTimeMilliseconds = 120000;
            }
            gameState = GAME_STATE_BENCHMARKING;
            engine = new ComputeEngine();

            windowStartWidth  = 1280;
            windowStartHeight = 720;

            numericUpDown1.Value = 1280;
            numericUpDown2.Value = 768;

            userControl = false;
            engine.setNumShipsThenAutoMapSize(65536); // max 64k ships
            engine.allocateArrays();
            engine.addCustomKernel(benchmarkKernels);
            scriptEngineState = engine.createCustomBufferOnGPU<int>(64*1024);
            benchmarkIntParameters = engine.getIntParametersGPU();
            benchmarkFloatParameters = engine.getFloatParametersGPU();

            benchmarkStep= engine.createCustomTask(scriptEngineState, "incrementBenchmarkFrame", 1, 1);

            benchmarkIntParameters.read = false;
            benchmarkIntParameters.write = false;
            benchmarkFloatParameters.read = false;
            benchmarkFloatParameters.write = false;

            benchmarkRandBuf = engine.getRandBufferGPU();
            benchmarkShipHp = engine.getShipHpBufferGPU();
            benchmarkShipHp.read = false;
            benchmarkShipHp.write = false;
            benchmarkShipHpMax = engine.getShipHpMaxBufferGPU();
            benchmarkShipTargetX = engine.getShipTargetXGPU();
            benchmarkShipTargetX.read = false;
            benchmarkShipTargetX.write = false;
            benchmarkShipTargetY = engine.getShipTargetYGPU();
            benchmarkShipTargetShip = engine.getShipTargetShipGPU();
            benchmarkShipTargetShip.read = false;
            benchmarkShipTargetShip.write = false;
            benchmarkShipSelected = engine.getShipSelectedGPU();
            benchmarkShipSelected.read = false;
            benchmarkShipSelected.write = false;
            benchmarkShipTargetY.read = false;
            benchmarkShipTargetY.write = false;
            benchmarkShipHpMax.read = false;
            benchmarkShipHpMax.write = false;
            benchmarkRandBuf.read = false;
            benchmarkRandBuf.write = false;


            // 4M script command, 8M command parameter, 16M data elements(float + int)
            scriptCommand = engine.createCustomBufferOnGPU<int>(1024*1024*4);
            scriptCommandParameter = engine.createCustomBufferOnGPU<float>(1024 * 1024 * 8);
            dataInt = engine.createCustomBufferOnGPU<int>(1024 * 1024 * 16);
            dataFloat = engine.createCustomBufferOnGPU<float>(1024 * 1024 * 16);

            // setup script
            scriptCommandPointer = engine.createCustomBufferOnGPU<int>(1024 * 64);
            benchmarkScriptSetup = engine.createCustomTask(
                scriptEngineState.nextParam(scriptCommand, scriptCommandParameter, 
                scriptCommandPointer,dataInt, dataFloat, benchmarkRandBuf),
                "setup720pBenchmarkScript", 1, 1);


            frameTime = engine.getFrameTimeBufferGPU();
            frameTimeInner = engine.createCustomBufferOnGPU<float>(1024 * 64);
            frameTime.read = false;
            frameTime.write = false;

            benchmarkShipX = engine.getShipXBufferGPU();
            benchmarkShipXOld = engine.getShipXOldBufferGPU();
            benchmarkShipY = engine.getShipYBufferGPU();
            benchmarkShipYOld = engine.getShipYOldBufferGPU();
            benchmarkShipTeam = engine.getShipTeamBufferGPU();
            benchmarkShipSizeType = engine.getShipSizeTypeBufferGPU();
            benchmarkShipModuleType = engine.getShipModuleTypeBufferGPU();
            benchmarkShipModuleEnergy = engine.getShipModuleEnergyBufferGPU();
            benchmarkShipModuleEnergyMax = engine.getShipModuleEnergyMaxBufferGPU();
            benchmarkShipModuleHP = engine.getShipModuleHPBufferGPU();
            benchmarkShipModuleHPMax= engine.getShipModuleHPMaxBufferGPU();
            benchmarkShipModuleState = engine.getShipModuleStateBufferGPU();
            benchmarkShipModuleWeight = engine.getShipModuleWeightBufferGPU();
            benchmarkShipShield = engine.getShipShieldBufferGPU();
            benchmarkShipShieldMax = engine.getShipShieldMaxBufferGPU();

            benchmarkShipState = engine.getShipStateBufferGPU();
            benchmarkShipRotation = engine.getShipRotationBufferGPU();
            benchmarkShipRotation.read = false;
            benchmarkShipRotation.write = false;
            benchmarkShipState.read = false;
            benchmarkShipState.write = false;

            benchmarkShipShield.read = false;
            benchmarkShipShield.write = false;
            benchmarkShipShieldMax.read = false;
            benchmarkShipShieldMax.write = false;
            benchmarkShipModuleWeight.read = false;
            benchmarkShipModuleWeight.write = false;
            benchmarkShipModuleState.read = false;
            benchmarkShipModuleState.write = false;
            benchmarkShipModuleHP.read = false;
            benchmarkShipModuleHP.write = false;
            benchmarkShipModuleHPMax.read = false;
            benchmarkShipModuleHPMax.write = false;
            benchmarkShipModuleEnergy.read = false;
            benchmarkShipModuleEnergy.write = false;
            benchmarkShipModuleEnergyMax.read = false;
            benchmarkShipModuleEnergyMax.write = false;
            benchmarkShipModuleType.read = false;
            benchmarkShipModuleType.write = false;
            benchmarkShipSizeType.read = false;
            benchmarkShipSizeType.write = false;
            benchmarkShipTeam.read = false;
            benchmarkShipTeam.write = false;
            benchmarkShipX.read=false;
            benchmarkShipY.read = false;
            benchmarkShipX.write = false;
            benchmarkShipY.write = false;

            benchmarkShipXOld.read = false;
            benchmarkShipYOld.read = false;
            benchmarkShipXOld.write = false;
            benchmarkShipYOld.write = false;

            // scriptWorkerN threads run script
            scriptEngine = engine.createCustomTask(
                scriptCommand.nextParam(scriptCommandParameter, scriptCommandPointer, 
                scriptEngineState, benchmarkIntParameters, benchmarkFloatParameters, frameTime,
                frameTimeInner, benchmarkShipX, benchmarkShipY,dataInt,benchmarkShipXOld,benchmarkShipYOld, 
                dataFloat, benchmarkShipTeam, benchmarkShipSizeType, benchmarkShipModuleType,
                benchmarkShipModuleEnergy,benchmarkShipModuleEnergyMax,
                benchmarkShipModuleHP, benchmarkShipModuleHPMax,
                benchmarkShipModuleState,benchmarkShipModuleWeight,
                benchmarkShipShield,benchmarkShipShieldMax, benchmarkRandBuf,
                benchmarkShipState, benchmarkShipRotation,
                benchmarkShipHp, benchmarkShipHpMax,
                benchmarkShipTargetX,benchmarkShipTargetY, benchmarkShipSelected, benchmarkShipTargetShip),
                "scriptEngine scriptEngine", scriptWorkerN, 256);


            engine.insertCustomTaskIntoPipeline(benchmarkStep);
            engine.insertCustomTaskIntoPipeline(benchmarkScriptSetup);
            engine.insertCustomTaskIntoPipeline(scriptEngine);
            engine.initCustomTaskArray();
            lock (teamSync)
            {
                team = -1;
                benchModeSelected = true;
            }
            for (int d = 0; d < but.Length; d++)
            {
                but[d].Visible=true;
            }
            button6.Visible = false;
            benchmark720p.Visible = false;
            button4.Visible = false;
            button5.Visible = false;
        }

        private void button6_Click(object sender, EventArgs e)
        {
            this.Invoke((MethodInvoker)delegate {
                this.Width = playModeW;
                this.Height = playModeH;

                panel2.Visible = true;
                button6.Visible = false;
                benchmark720p.Visible = false;
                button4.Visible = false;
                button5.Visible = false;
                for (int d = 0; d < but.Length; d++)
                {
                    but[d].Parent = panel2;
                    but[d].Visible = true;
                }
                engine = new ComputeEngine();

            });
        }

        // 1080p benchmark
        private void button4_Click(object sender, EventArgs e)
        {
            // counting for #define lines
            benchmarkKernels = replaceUid(benchmarkKernels).Replace("@@scriptWorkerN@@", scriptWorkerN.ToString());
            lock (benchTimeSync)
            {
                benchmarkTimeMilliseconds = 120000;
            }
            gameState = GAME_STATE_BENCHMARKING;
            engine = new ComputeEngine();

            windowStartWidth = 1920;
            windowStartHeight = 1080; // visible part

            numericUpDown1.Value = 1920; // multiple of 64
            numericUpDown2.Value = 1088; // real render multiple of 64

            userControl = false;
            engine.setNumShipsThenAutoMapSize(65536 * 2); // max 128k ships
            engine.allocateArrays();
            engine.addCustomKernel(benchmarkKernels);
            scriptEngineState = engine.createCustomBufferOnGPU<int>(64 * 1024); // enough to hold 15 states per worker for 256 workers
            benchmarkIntParameters = engine.getIntParametersGPU();
            benchmarkFloatParameters = engine.getFloatParametersGPU();

            benchmarkStep = engine.createCustomTask(scriptEngineState, "incrementBenchmarkFrame", 1, 1);

            benchmarkIntParameters.read = false;
            benchmarkIntParameters.write = false;
            benchmarkFloatParameters.read = false;
            benchmarkFloatParameters.write = false;

            benchmarkRandBuf = engine.getRandBufferGPU();
            benchmarkShipHp = engine.getShipHpBufferGPU();
            benchmarkShipHp.read = false;
            benchmarkShipHp.write = false;
            benchmarkShipHpMax = engine.getShipHpMaxBufferGPU();
            benchmarkShipTargetX = engine.getShipTargetXGPU();
            benchmarkShipTargetX.read = false;
            benchmarkShipTargetX.write = false;
            benchmarkShipTargetY = engine.getShipTargetYGPU();
            benchmarkShipTargetShip = engine.getShipTargetShipGPU();
            benchmarkShipTargetShip.read = false;
            benchmarkShipTargetShip.write = false;
            benchmarkShipSelected = engine.getShipSelectedGPU();
            benchmarkShipSelected.read = false;
            benchmarkShipSelected.write = false;
            benchmarkShipTargetY.read = false;
            benchmarkShipTargetY.write = false;
            benchmarkShipHpMax.read = false;
            benchmarkShipHpMax.write = false;
            benchmarkRandBuf.read = false;
            benchmarkRandBuf.write = false;


            // 16M script command, 32M command parameter, 16M data elements(float + int)
            scriptCommand = engine.createCustomBufferOnGPU<int>(1024 * 1024 * 16);
            scriptCommandParameter = engine.createCustomBufferOnGPU<float>(1024 * 1024 * 32);
            dataInt = engine.createCustomBufferOnGPU<int>(1024 * 1024 * 64);
            dataFloat = engine.createCustomBufferOnGPU<float>(1024 * 1024 * 64);

            // setup script
            scriptCommandPointer = engine.createCustomBufferOnGPU<int>(1024 * 64); // enough to hold 1 command pointer per worker for 256 workers
            benchmarkScriptSetup = engine.createCustomTask(
                scriptEngineState.nextParam(scriptCommand, scriptCommandParameter,
                scriptCommandPointer, dataInt, dataFloat, benchmarkRandBuf),
                "setup1080pBenchmarkScript", 1, 1);


            frameTime = engine.getFrameTimeBufferGPU();
            frameTimeInner = engine.createCustomBufferOnGPU<float>(1024*64);
            frameTime.read = false;
            frameTime.write = false;

            benchmarkShipX = engine.getShipXBufferGPU();
            benchmarkShipXOld = engine.getShipXOldBufferGPU();
            benchmarkShipY = engine.getShipYBufferGPU();
            benchmarkShipYOld = engine.getShipYOldBufferGPU();
            benchmarkShipTeam = engine.getShipTeamBufferGPU();
            benchmarkShipSizeType = engine.getShipSizeTypeBufferGPU();
            benchmarkShipModuleType = engine.getShipModuleTypeBufferGPU();
            benchmarkShipModuleEnergy = engine.getShipModuleEnergyBufferGPU();
            benchmarkShipModuleEnergyMax = engine.getShipModuleEnergyMaxBufferGPU();
            benchmarkShipModuleHP = engine.getShipModuleHPBufferGPU();
            benchmarkShipModuleHPMax = engine.getShipModuleHPMaxBufferGPU();
            benchmarkShipModuleState = engine.getShipModuleStateBufferGPU();
            benchmarkShipModuleWeight = engine.getShipModuleWeightBufferGPU();
            benchmarkShipShield = engine.getShipShieldBufferGPU();
            benchmarkShipShieldMax = engine.getShipShieldMaxBufferGPU();

            benchmarkShipState = engine.getShipStateBufferGPU();
            benchmarkShipRotation = engine.getShipRotationBufferGPU();
            benchmarkShipRotation.read = false;
            benchmarkShipRotation.write = false;
            benchmarkShipState.read = false;
            benchmarkShipState.write = false;

            benchmarkShipShield.read = false;
            benchmarkShipShield.write = false;
            benchmarkShipShieldMax.read = false;
            benchmarkShipShieldMax.write = false;
            benchmarkShipModuleWeight.read = false;
            benchmarkShipModuleWeight.write = false;
            benchmarkShipModuleState.read = false;
            benchmarkShipModuleState.write = false;
            benchmarkShipModuleHP.read = false;
            benchmarkShipModuleHP.write = false;
            benchmarkShipModuleHPMax.read = false;
            benchmarkShipModuleHPMax.write = false;
            benchmarkShipModuleEnergy.read = false;
            benchmarkShipModuleEnergy.write = false;
            benchmarkShipModuleEnergyMax.read = false;
            benchmarkShipModuleEnergyMax.write = false;
            benchmarkShipModuleType.read = false;
            benchmarkShipModuleType.write = false;
            benchmarkShipSizeType.read = false;
            benchmarkShipSizeType.write = false;
            benchmarkShipTeam.read = false;
            benchmarkShipTeam.write = false;
            benchmarkShipX.read = false;
            benchmarkShipY.read = false;
            benchmarkShipX.write = false;
            benchmarkShipY.write = false;

            benchmarkShipXOld.read = false;
            benchmarkShipYOld.read = false;
            benchmarkShipXOld.write = false;
            benchmarkShipYOld.write = false;

            // scriptWorkerN threads run script
            scriptEngine = engine.createCustomTask(
                scriptCommand.nextParam(scriptCommandParameter, scriptCommandPointer,
                scriptEngineState, benchmarkIntParameters, benchmarkFloatParameters, frameTime,
                frameTimeInner, benchmarkShipX, benchmarkShipY, dataInt, benchmarkShipXOld, benchmarkShipYOld,
                dataFloat, benchmarkShipTeam, benchmarkShipSizeType, benchmarkShipModuleType,
                benchmarkShipModuleEnergy, benchmarkShipModuleEnergyMax,
                benchmarkShipModuleHP, benchmarkShipModuleHPMax,
                benchmarkShipModuleState, benchmarkShipModuleWeight,
                benchmarkShipShield, benchmarkShipShieldMax, benchmarkRandBuf,
                benchmarkShipState, benchmarkShipRotation,
                benchmarkShipHp, benchmarkShipHpMax,
                benchmarkShipTargetX, benchmarkShipTargetY, benchmarkShipSelected, benchmarkShipTargetShip),
                "scriptEngine scriptEngine", scriptWorkerN, 256);


            engine.insertCustomTaskIntoPipeline(benchmarkStep);
            engine.insertCustomTaskIntoPipeline(benchmarkScriptSetup);
            engine.insertCustomTaskIntoPipeline(scriptEngine);
            engine.initCustomTaskArray();
            lock (teamSync)
            {
                team = -1;
                benchModeSelected = true;
            }
            for (int d = 0; d < but.Length; d++)
            {
                but[d].Visible = true;
            }
            button6.Visible = false;
            benchmark720p.Visible = false;
            button4.Visible = false;
            button5.Visible = false;

        }

        private void button5_Click(object sender, EventArgs e)
        {

        }

        private void progressBar1_Click(object sender, EventArgs e)
        {

        }

        private void label102_Click(object sender, EventArgs e)
        {
           
        }

        private void menuStrip1_ItemClicked(object sender, ToolStripItemClickedEventArgs e)
        {

        }

        private void fromDonanimhabercomHardwareForumToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }
    }
}
