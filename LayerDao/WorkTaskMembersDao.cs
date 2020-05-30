using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;

namespace LayerDao
{
   public static class WorkTaskMembersDao
    {
        public static List<WorkTaskMembers> GetAll()
        {
            return TableConstants.WorkTaskMembers.SelectAll<WorkTaskMembers>();
        }
        public static WorkTaskMembers GetById(long id)
        {
            return TableConstants.WorkTaskMembers.Select<WorkTaskMembers>((int)id);
        }

        public static List<WorkTaskMembers> GetByUserId(string userId,long memberTypeId)
        {
            var where = $"where AspNetUserId='{userId}' AND ProjectMemberTypeId={memberTypeId};";
            return ViewConstants.UserTaskView.SelectList<WorkTaskMembers>(where);
        }

        public static List<WorkTaskMembers> GetByUserId(string userId)
        {
            var where = $"where AspNetUserId='{userId}';";
            return ViewConstants.UserTaskView.SelectList<WorkTaskMembers>(where);
        }

        public static List<WorkTaskMembers> GetAllTask()
        {
            return ViewConstants.UserTaskView.SelectAll<WorkTaskMembers>();
        }

        public static bool CheckMemberExists(string userId,long memberTypeId,long workTaskId)
        {
            var where = $"AspNetUserId='{userId}' AND MemberTypeId = {memberTypeId} AND WorkTaskId = {workTaskId}";
            return TableConstants.WorkTaskMembers.Select<WorkTaskMembers>(where)==null?false:true;
        }

        public static bool Insert(WorkTaskMembers workTaskMembers)
        {
            return workTaskMembers.Insert(TableConstants.WorkTaskMembers) > 0;
        }
        public static bool Update(WorkTaskMembers workTaskMembers)
        {
            return workTaskMembers.Update(TableConstants.WorkTaskMembers, (int)workTaskMembers.Id) > 0;
        }
        public static bool Delete(long id)
        {
            return TableConstants.WorkTaskMembers.Delete((int)id);
        }
    }
}
