﻿using System;
using System.Collections.Generic;
using System.Text;

namespace Generics.DataModels
{
    public class SendEmailModel
    {
        public string From { get; set; }
        public string Subject { get; set; }
        public string Body { get; set; }
        public string To { get; set; }
    }
}
