using Generics.DataModels.AdminModels;
using LayerDao;
using System.Collections.Generic;

namespace LayerBao
{
    public static class WorkTaskMembersBao
    {
        public static List<WorkTaskMembers> GetAll()
        {
            return WorkTaskMembersDao.GetAll();
        }
        public static WorkTaskMembers GetById(long id)
        {
            return WorkTaskMembersDao.GetById(id);
        }
        public static List<WorkTaskMembers> GetByUserId(string id, long memberTypeId)
        {
            return WorkTaskMembersDao.GetByUserId(id, memberTypeId);
        }
        public static List<UserTask> GetUserTasks(string id)
        {
            return WorkTaskMembersDao.GetUserTasks(id);
        }
        public static Dictionary<string,List<UserTask>> GetUserTasks(List<string> id)
        {
            return WorkTaskMembersDao.GetUserTasks(id);
        }
        public static List<WorkTaskMembers> GetByUserId(string id)
        {
            return WorkTaskMembersDao.GetByUserId(id);
        }

        public static List<WorkTaskMembers> GetAllTask()
        {
            return WorkTaskMembersDao.GetAllTask();
        }

        public static bool CheckMemberExists(string userId, long memberTypeId, long workTaskId)
        {
            return WorkTaskMembersDao.CheckMemberExists(userId, memberTypeId, workTaskId);
        }
        public static bool Insert(WorkTaskMembers workTaskMembers)
        {
            return WorkTaskMembersDao.Insert(workTaskMembers);
        }
        public static bool Update(WorkTaskMembers workTaskMembers)
        {
            return WorkTaskMembersDao.Update(workTaskMembers);
        }
        public static bool Delete(long id)
        {
            return WorkTaskMembersDao.Delete(id);
        }

        public static bool UpdateExistingWorkTaskMembers(ProjectMembers member, string userId)
        {
            return WorkTaskMembersDao.UpdateExistingWorkTaskMembers(member, userId);
        }
    }
}
