using System;
using System.Collections.Generic;
using System.Text;
using System.Net;
using System.IO;
using System.Diagnostics;
using System.DirectoryServices;

namespace MyCompany.IIS
{
    public static class IISController
    {

        #region Create Site
        public static bool CreateSite(string metabasePath,
                                      string siteName,
                                      string physicalPath,
                                      string ipAddress,
                                      string hostHeader,
                                      string dotNetVersion)
        {

            try
            {
                return CreateSite(metabasePath,
                                  siteName,
                                  physicalPath,
                                  ipAddress,
                                  hostHeader,
                                  dotNetVersion,
                                  null,
                                  null);
            }
            catch { throw; }
        }
        #endregion

        #region Create Site
        public static bool CreateSite(string metabasePath,
                                      string siteName,
                                      string physicalPath,
                                      string ipAddress,
                                      string hostHeader,
                                      string dotNetVersion,
                                      string windowsUserName,
                                      string windowsUserPassword)
        {
            int siteID = -1;
            object[] hosts = new object[2];
            string appPoolID = "";
            string newMetaBasePath = "";

            try
            {

                hostHeader = hostHeader.Replace("www.", "");

                hosts[0] = ipAddress + ":80:" + hostHeader;
                hosts[1] = ipAddress + ":80:" + "www." + hostHeader;

                siteID = GetNextAvailableSiteID(metabasePath);

                appPoolID = CreateAppPool(metabasePath + "/AppPools", hostHeader);

                CreateIISSite(metabasePath, siteID.ToString(), siteName, physicalPath, appPoolID, hosts);

                newMetaBasePath = metabasePath + "/" + siteID.ToString() + "/Root";

                if ((windowsUserName != null) && (windowsUserPassword != null))
                {
                    if ((windowsUserName.Trim().Length > 0) && (windowsUserPassword.Trim().Length > 0))
                    {
                        SetSingleProperty(newMetaBasePath, "AnonymousUserName", windowsUserName.Trim());
                        SetSingleProperty(newMetaBasePath, "AnonymousUserPass", windowsUserPassword.Trim());
                        SetSingleProperty(newMetaBasePath, "AnonymousPasswordSync", true);
                    }
                }

                RegisterASPNETApplicationVersion("W3SVC/" + siteID + "/Root", dotNetVersion);

                return true;
            }
            catch { throw; }
        }
        #endregion

        #region Create IIS Site
        private static void CreateIISSite(string metabasePath,
                                          string siteID,
                                          string siteName,
                                          string physicalPath,
                                          string appPoolID,
                                          object[] hosts)
        {
            //  metabasePath is of the form "IIS://<servername>/<service>"
            //  for example "IIS://localhost/W3SVC" 
            //  siteID is of the form "<number>", for example "555"
            //  siteName is of the form "<name>", for example, "My New Site"
            //  physicalPath is of the form "<drive>:\<path>", for example, "C:\Inetpub\Wwwroot"

            try
            {
                DirectoryEntry service = new DirectoryEntry(metabasePath);
                string className = service.SchemaClassName.ToString();

                if (!className.EndsWith("Service")) { return; }

                DirectoryEntries sites = service.Children;
                DirectoryEntry newSite = sites.Add(siteID, (className.Replace("Service", "Server")));
                newSite.Properties["ServerComment"][0] = siteName;
                newSite.Properties["ServerBindings"].Value = hosts;
                newSite.Invoke("Put", "ServerAutoStart", 1);
                newSite.Invoke("Put", "ServerSize", 1);
                newSite.CommitChanges();

                DirectoryEntry siteVDir;
                siteVDir = newSite.Children.Add("Root", "IIsWebVirtualDir");
                siteVDir.Properties["Path"][0] = physicalPath;
                siteVDir.Properties["EnableDefaultDoc"][0] = true;
                siteVDir.Properties["DefaultDoc"].Value = "default.aspx";
                siteVDir.Properties["AppIsolated"][0] = 2;
                siteVDir.Properties["AccessRead"][0] = true;
                siteVDir.Properties["AccessWrite"][0] = false;
                siteVDir.Properties["AccessScript"][0] = true;
                siteVDir.Properties["AccessFlags"].Value = 513;
                siteVDir.Properties["AppRoot"][0] = @"/LM/W3SVC/" + siteID.ToString() + "/Root";
                siteVDir.Properties["AppPoolId"].Value = appPoolID;
                siteVDir.Properties["AuthNTLM"][0] = true;
                siteVDir.Properties["AuthAnonymous"][0] = true;
                siteVDir.CommitChanges();

            }
            catch { throw; }
        }
        #endregion


        #region Register ASPNET Application Version
        private static void RegisterASPNETApplicationVersion(string applicationMetaPath,
                                                             string dotNetVersion)
        {
            string aspnet = "";

            try
            {

                dotNetVersion = dotNetVersion.Replace("v", "");

                aspnet = string.Format(@"{0}\Microsoft.NET\Framework\v{1}\aspnet_regiis.exe",
                                              Environment.GetEnvironmentVariable("windir"),
                                              dotNetVersion);

                ProcessStartInfo startInfo = new ProcessStartInfo(aspnet);

                startInfo.Arguments = string.Format("-sn \"{0}\"", applicationMetaPath);
                startInfo.WindowStyle = ProcessWindowStyle.Hidden;
                startInfo.UseShellExecute = false;
                startInfo.CreateNoWindow = true;

                Process process = new Process();
                process.StartInfo = startInfo;
                process.Start();
                process.WaitForExit();
                process.Dispose();

            }
            catch { throw; }

        }
        #endregion



        #region Create Virtual Directory
        public static bool CreateVirtualDirectory(string metabasePath,
                                                  string virtualDirectoryName,
                                                   string physicalPath)
        {
            //  metabasePath is of the form "IIS://<servername>/<service>/<siteID>/Root[/<vdir>]"
            //    for example "IIS://localhost/W3SVC/1/Root" 
            //  vDirName is of the form "<name>", for example, "MyNewVDir"
            //  physicalPath is of the form "<drive>:\<path>", for example, "C:\Inetpub\Wwwroot"


            try
            {
                DirectoryEntry site = new DirectoryEntry(metabasePath);
                string className = site.SchemaClassName.ToString();

                if ((className.EndsWith("Server")) || (className.EndsWith("VirtualDir")))
                {
                    DirectoryEntries vdirs = site.Children;
                    DirectoryEntry newVDir = vdirs.Add(virtualDirectoryName,
                                   (className.Replace("Service", "VirtualDir")));
                    newVDir.Properties["Path"][0] = physicalPath;
                    newVDir.Properties["AccessScript"][0] = true;
                    // These properties are necessary for an application to be created.
                    newVDir.Properties["AppFriendlyName"][0] = virtualDirectoryName;
                    newVDir.Properties["AppIsolated"][0] = "1";
                    newVDir.Properties["AppRoot"][0] = "/LM" +
                   metabasePath.Substring(metabasePath.IndexOf("/", ("IIS://".Length)));

                    newVDir.CommitChanges();

                    return true;
                }

                return false;

            }
            catch { throw; }
        }
        #endregion

        #region Create App Pool
        public static string CreateAppPool(string metabasePath, string appPoolName)
        {

            try
            {
                if (!metabasePath.EndsWith("/W3SVC/AppPools"))
                {
                    throw new Exception("metaBasePath " + metabasePath
                         + " is invalid.  It must end with W3SVC/AppPools");
                }

                DirectoryEntry newPool;
                DirectoryEntry appPools = new DirectoryEntry(metabasePath);

                foreach (DirectoryEntry entry in appPools.Children)
                {

                    if (entry.Name.ToLower() == appPoolName.ToLower())
                    {
                        return entry.Name;
                    }

                }

                newPool = appPools.Children.Add(appPoolName, "IIsApplicationPool");
                
                newPool.CommitChanges();

                newPool = new DirectoryEntry(metabasePath + "/" + appPoolName);

                newPool.Properties["PeriodicRestartMemory"].Value = "0";
                newPool.Properties["PeriodicRestartPrivateMemory"].Value = "0";


                newPool.Properties["managedRuntimeVersion"].Value = "v4.0";


                newPool.CommitChanges();

                return appPoolName;
            }
            catch { throw; }
        }
        #endregion

        #region Set Single Property
        public static bool SetSingleProperty(string metabasePath,
                                             string propertyName,
                                             object newValue)
        {
            //  metabasePath is of the form "IIS://<servername>/<path>"
            //    for example "IIS://localhost/W3SVC/1" 
            //  propertyName is of the form "<propertyName>", for example "ServerBindings"
            //  value is of the form "<intStringOrBool>", for example, ":80:"


            try
            {
                DirectoryEntry path = new DirectoryEntry(metabasePath);


                path.Properties[propertyName][0] = newValue;
                path.CommitChanges();
                return true;

            }
            catch { throw; }
        }
        #endregion

        #region Get Next Available Site ID
        public static int GetNextAvailableSiteID(string metabasePath)
        {
            int siteID = 101;

            try
            {
                DirectoryEntry root = new DirectoryEntry(metabasePath);


                foreach (DirectoryEntry e in root.Children)
                {
                    if (e.SchemaClassName == "IIsWebServer")
                    {
                        int ID = Convert.ToInt32(e.Name);

                        if (ID >= siteID)
                        {
                            siteID = ID + 1;
                        }
                    }
                }
            }
            catch { throw; }
            return siteID;
        }
        #endregion

    }
}