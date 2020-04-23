using System.Runtime.InteropServices;

public static class OperatingSystem
{
    public static bool IsWindows { get { return RuntimeInformation.IsOSPlatform(OSPlatform.Windows); } }
    public static bool IsMacOS { get { return RuntimeInformation.IsOSPlatform(OSPlatform.OSX); } }
    public static bool IsLinux { get { return RuntimeInformation.IsOSPlatform(OSPlatform.Linux); } }
}