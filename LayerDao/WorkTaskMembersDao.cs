using Generics.Common;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;
using System.Collections.Generic;
using System.Linq;

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

        public static List<WorkTaskMembers> GetByUserId(string userId, long memberTypeId)
        {
            var where = $" AspNetUserId='{userId}' AND ProjectMemberTypeId={memberTypeId};";
            return ViewConstants.USER_TASK_VIEW.SelectList<WorkTaskMembers>(where);
        }
        public static List<WorkTaskMemberCompact> GetWorkTaskMemberTypeByUserId(string userId)
        {
            var where = $" UserId = '{userId}'";
            return ViewConstants.WORK_TASK_MEMBER_VIEW.SelectList<WorkTaskMemberCompact>(where);
        }

        public static List<UserTask> GetUserTasks(string id)
        {
            var where = $" AspNetUserId='{id}'";
            return ViewConstants.USER_TASK_VIEW.SelectList<UserTask>(where);
        }
        public static List<WorkTaskMembers> GetByUserId(string userId)
        {
            var where = $"where AspNetUserId='{userId}';";
            return ViewConstants.USER_TASK_VIEW.SelectList<WorkTaskMembers>(where);
        }

        public static List<WorkTaskMembers> GetAllTask()
        {
            return ViewConstants.USER_TASK_VIEW.SelectAll<WorkTaskMembers>();
        }

        public static bool CheckMemberExists(string userId, long memberTypeId, long workTaskId)
        {
            var where = $"AspNetUserId='{userId}' AND MemberTypeId = {memberTypeId} AND WorkTaskId = {workTaskId}";
            return TableConstants.WorkTaskMembers.Select<WorkTaskMembers>(where) == null ? false : true;
        }

        public static bool UpdateExistingWorkTaskMembers(ProjectMembers member, string userId)
        {
            if (member == null) return false;

            var memberType = ProjectMemberTypeDao.GetById(member.ProjectMemberTypeId);
            if (memberType == null) return false;

            var isDesigner = memberType.Name.ToLower() == "designer";
            var isScheduler = memberType.Name.ToLower() == "scheduler";
            if (!isDesigner && !isScheduler) return false;

            var timeFilter = $" AND (CONVERT(VARCHAR(10),ProjectSchedulingTime, 110) = '{DataConstants.LocalNow.ToString("MM-dd-yyyy")}' OR CONVERT(VARCHAR(10),ProjectSchedulingTime, 110) = '{DataConstants.LocalNow.AddDays(1).ToString("MM-dd-yyyy")}' )";
            var workTaskQueryWhere = $" ProjectId = {member.ProjectId} {(isDesigner ? "AND IsDesigned = 0" : "")} {(isScheduler ? "AND IsScheduled = 0" : "")} {timeFilter} ";
            var workTasks = TableConstants.WorkTask.SelectList<WorkTask>(workTaskQueryWhere) ?? new List<WorkTask>();
            if (workTasks.Count == 0) return true;

            string workTaskIds = workTasks.Count == 1
                ? workTasks.FirstOrDefault().Id + ""
                : workTasks.Select(a => a.Id + "").Aggregate((c, n) => $"{c},{n}");


            var deleteQuery = $"DELETE FROM dbo.WorkTaskMembers WHERE MemberTypeId = {member.ProjectMemberTypeId} AND WorkTaskId IN ({workTaskIds})";
            return QueryExecutor.ExecuteDml(deleteQuery);

            //workTasks.Select()

            //var workTaskMembers = TableConstants.WorkTaskMembers.SelectList<WorkTaskMembers>(where) ?? new List<WorkTaskMembers>();
            //if (workTaskMembers.Count == 0) return true;
            //string ids = workTaskMembers.Count == 1
            //    ? workTaskMembers.FirstOrDefault().Id + ""
            //    : workTaskMembers.Select(a => a.Id + "").Aggregate((c, n) => $"{c},{n}");

            //var updateQuery = $"UPDATE dbo.WorkTaskMembers SET AspNetUserId = '{member.AspNetUserId}', OnModified = {DataConstants.LocalNow} " +
            //    $"WHERE Id IN ({ids})";

            //return QueryExecutor.ExecuteDml(updateQuery);
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
