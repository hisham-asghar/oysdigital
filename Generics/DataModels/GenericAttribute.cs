﻿using System;
using System.Collections.Generic;
using System.Text;

namespace Generics.DataModels
{
    /// <summary>
    /// Represents a generic attribute
    /// </summary>
    public partial class GenericAttribute
    {
        public int Id { get; set; }
        /// <summary>
        /// Gets or sets the entity identifier
        /// </summary>
        public int EntityId { get; set; }

        /// <summary>
        /// Gets or sets the key group
        /// </summary>
        public string KeyGroup { get; set; }

        /// <summary>
        /// Gets or sets the key
        /// </summary>
        public string Key { get; set; }

        /// <summary>
        /// Gets or sets the value
        /// </summary>
        public string Value { get; set; }

        /// <summary>
        /// Gets or sets the store identifier
        /// </summary>
        public int StoreId { get; set; }
        
    }
}
