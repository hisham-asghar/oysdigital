using Google.Apis.Auth.OAuth2;
using Google.Apis.Gmail.v1;
using Google.Apis.Services;

namespace LayerBAO.GoogleBao
{
    public class GoogleBase
    {
        const string PrivateKey =
            "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC+YT/wrjmvkqOg\np35mlhcnJ3w7fJxme6THs1RDvNldY0yDgVpTxPhDhq9h8XiwgUgPSScOAai0jz5r\nk7cnO7tVUpOUKvVnLEXpPE4nX4XLbZSW6f4njFxILc0Iv3sQcZq++kmOy7p4Yb61\nkVkL/6juPj6R25p9ssotw0kY1OnoIX1qf3+PkXiehpcsf1YMJnm7cWDTibKK+aag\nsDFW7n1SJm83uR33USTUsORldaMntQh0kFI8U9EM1fme/hBf9U7dNBVd7vPPZPgK\npAwEfv2nvKPOLP96lU1+A8dlP/80VGaVNuSuWNLJVxeW3QKwBaz85UnkjHUCcmu2\njAMtWOrdAgMBAAECggEAUpt2GCQxKarST0J+SVs0/qtWb6V5Y8qgzHpWxPGry6br\nq2A0ZobgRsSpUzFo8gWW0/Mk/CHiJz7Ekf9NiLuVZMdo+/DL/RGr4DFnpBQBxSxu\nPjGYM2bnH/ansfUMHC1/PQDza/+gkN2w164S2m77ySy/D6EfXw12Rvcmv5ybRjqI\nWJbvs9P6Lc715aDlzEleOxAIJ3gaY3MlCOOEJKZS8LuU/jOOwOaa9PMhsoGSsK8g\nZZHYgPtXHikqPRDIfz/Om1itJpc5+xeaVEgCKu4ikJzHakNPEKeTpfiFMfmJMCSw\nGbh+MQq/Ya0K33VNhoNsJxnKQIRK28a0JIvkyNByLQKBgQD+vLQ9W7hit+Q7V/rd\nIl2pi+KYMNGbeA2DXPyrYIT2huhjWTQrlADRpKgSPDDN/xwQgMtG6M7Nk5HUX7N8\nMUBXAhoIZ5yxgCUVJzQTGY6dGt20gjLCzDrSzxprE0E3BSqYhsMC7nHWaB5oP9F9\nFLc/peibrZvadQZXgoPFaYrvUwKBgQC/Ut4drE+38fwkUPoVkhBglrRSVMY+PPoD\n2I8r5seoq1VUNIE/TMlhg679Vvr8C+QC8BXnGjGo7GmsN6zVoRjcEHAr9HRWOEwb\nkXxkPEEo6wFgpSOptXyM6HiayH7kndbhy4F8NQztTlb0dKJY9zPvqYVqBN0lcK59\ncpI8Q5vnDwKBgEThT7dbqsL+yHcHdiz/UuY6jf3rDXKFhtnjder9QVbL6eCbSVET\nRxlo9Y1guy2ocrU/rjexUeIiqgcMDaNiSex9A/8LzUHtzZknrZwQiBCRKCvcHM+x\nm6JPH+yeGz8+ZWMy5V5QjXWVV8uGniW9SUOrn/cgfYkXpaxZ/TmPLWNDAoGAbuV2\nj5aIIqPltZsmSgh+662O2cX/nqWzeTU2T4kWI6Mj84n3fJxigd5VOM0I771orXdC\nCtF5BWP7IHKpAK6+/ReeHSw1nqBFJRmgE22Fi1UkWEOAN2dVyUsaVQVv383JdtmB\ntV/+nTJyXoGYdJ7dAMau6TPmh0QYL+iP8NRzcmsCgYEA7+zPSWm/LuBAl2hgVArr\nMbMuiZRFX0UM3aCfci8rxP3vfHzvAsJlns2BJp7v2fYTz4IaHMIWx6D+dk4fzFYX\n7Ozl5NXl8F0xZxjxS9fxl/CJMZZXppfPT8SFMl2ZQ5WrVedXooWWbGb3Qx+GlaSV\nsjadHZ0Ht3nzBp8gqJHVQtc=\n-----END PRIVATE KEY-----\n";

        public static GmailService GetMailService(string email = "hisham@octacer.com")
        {
            var credential = new ServiceAccountCredential(
                new ServiceAccountCredential.Initializer("octaceradmin@mystical-vial-234511.iam.gserviceaccount.com")
                {
                    User = email,
                    Scopes = new[]
                    {
                        GmailService.Scope.MailGoogleCom, GmailService.Scope.GmailSend, GmailService.Scope.GmailCompose
                        , GmailService.Scope.GmailInsert, GmailService.Scope.GmailLabels, GmailService.Scope.GmailModify
                    }
                }.FromPrivateKey(PrivateKey));
            var initializer = new BaseClientService.Initializer
            {
                HttpClientInitializer = credential,
                ApplicationName = "Octacer Portal"
            };
            return new GmailService(initializer);
        }

        //// Helpers
        //public static string GetServiceJson() =>
        //    SiteMetaDAO.getMeta("GoogleServiceAccount")?.MetaText;
        //private static BaseClientService.Initializer GetServiceInitializer(string[] scope)
        //{
        //    var credential = GetGoogleCredential(scope);
        //    if (credential == null) return null;
        //    return new BaseClientService.Initializer
        //    {
        //        HttpClientInitializer = credential,
        //        ApplicationName = "Octacer Portal"
        //    };
        //}

        //private static GoogleCredential GetGoogleCredential(string[] scope)
        //{
        //    if (scope?.Length == 0)
        //        return null;
        //    var json = null;// GetServiceJson();

        //    if (string.IsNullOrWhiteSpace(json))
        //        return null;
        //    var credential = GoogleCredential
        //        .FromJson(json)
        //        .CreateScoped(scope);
        //    return credential;
        //}
    }
}
