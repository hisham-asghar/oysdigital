using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Admin.Services.Logger
{
    public static class HomeLogger
    {
        private static readonly Action<ILogger, Exception> _indexPageRequested;
        static HomeLogger()
        {
            _indexPageRequested = LoggerMessage.Define(
                LogLevel.Information,
                new EventId(1, nameof(IndexPageRequested)),
                "GET request for Index page");
        }

        public static void IndexPageRequested(this ILogger logger)
        {
            _indexPageRequested(logger, null);
        }
    }
}
