using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels.AdminModels;
using LayerDao;

namespace LayerBao
{
    public class LabelTypeBao
    {
        public static List<LabelType> GetAll()
        {
            return LabelTypeDao.GetAll();
        }
        public static LabelType GetById(long id)
        {
            return LabelTypeDao.GetById(id);
        }
        public static bool Insert(LabelType labeltype)
        {
            return LabelTypeDao.Insert(labeltype);
        }
        public static bool Update(LabelType labeltype)
        {
            return LabelTypeDao.Update(labeltype);
        }
        public static bool Delete(long id)
        {
            return LabelTypeDao.Delete(id);
        }
    }
}
