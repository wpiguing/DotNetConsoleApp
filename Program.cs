using System;
using System.Threading;

namespace DotNetConsoleApp
{
    class Program
    {
        static void Main(string[] args)
        {
            int i = 0;
            while (i < 120)
            {
                Console.WriteLine("A .Net SDK 6.0 console app with a Servercore 2022 image, running in a windows container, pushed into ACR and deployed into AKS - " + i);
                Thread.Sleep(30000);
                i++;
            }
            
        }
    }
}
