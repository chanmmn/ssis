using System;
using Microsoft.SqlServer.Dts.Runtime;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConAppSsis
{
    class Program
    {
        static void Main(string[] args)
        {
            string pkgLocation;
            Package pkg;
            Application app;
            DTSExecResult pkgResults;

            pkgLocation =
              @"C:\test\ssis\ssis1\ssis1\Package.dtsx";
            app = new Application();
            pkg = app.LoadPackage(pkgLocation, null);
            pkgResults = pkg.Execute();

            Console.WriteLine(pkgResults.ToString());
            Console.ReadKey();
            //https://docs.microsoft.com/en-us/sql/integration-services/run-manage-packages-programmatically/loading-and-running-a-local-package-programmatically?view=sql-server-ver15
        }
    }
}
