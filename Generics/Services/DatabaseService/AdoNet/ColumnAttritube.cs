﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Generics.Services.DatabaseService.AdoNet
{
    public class Column : Attribute
    {
        public string Name { get; set; }
        public string TypeName { get; set; }
        public int Order { get; set; }
    }
}
