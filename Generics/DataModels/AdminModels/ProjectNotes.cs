using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Generics.DataModels.AdminModels
{
    public class ProjectNotes:BaseEntity
    {
        public string Message { get; set; }
        public int NoteTypeId { get; set; }
        public bool IsActive { get; set; }
    }
}
