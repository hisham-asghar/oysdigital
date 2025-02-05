﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Generics.DataModels
{
    public class UrlRecord
    {
        public int Id { get; set; }
        public int EntityId { get; set; }
        public string EntityName { get; set; }
        public string Slug { get; set; }
        public bool IsActive { get; set; }
        public int LanguageId { get; set; }
    }
}
