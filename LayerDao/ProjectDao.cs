using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;

namespace LayerDao
{
    public class ProjectDao
    {
        public static List<Project> GetAll()
        {
            var query = $"select Project.*,MobileSpaces.Name as MobileSpaceName,Customer.Name as CustomerName From Project Join MobileSpaces on Project.MobileSpaceId = MobileSpaces.id join Customer on Customer.Id = Project.CustomerId; ";
            return QueryExecutor.List<Project>(query);
        }
        public static Project GetById(long id)
        {
            var query = $"select Project.*,MobileSpaces.Name as MobileSpaceName,Customer.Name as CustomerName From Project Join MobileSpaces on Project.MobileSpaceId = MobileSpaces.id join Customer on Customer.Id = Project.CustomerId where Project.Id = {id}; ";
            return QueryExecutor.FirstOrDefault<Project>(query);
        }
        public static List<Project> GetByCustomerId(long id)
        {
            var query = $"select Project.*,MobileSpaces.Name as MobileSpaceName,Customer.Name as CustomerName From Project Join MobileSpaces on Project.MobileSpaceId = MobileSpaces.id join Customer on Customer.Id = Project.CustomerId where Customer.Id = {id}; ";
            return QueryExecutor.List<Project>(query);
        }
        public static List<Project> GetByMemberTypeId(long id)
        {
            var query = $"SELECT Project.*,MobileSpaces.Name as MobileSpaceName,Customer.Name as CustomerName FROM ProjectMembers INNER JOIN Project ON Project.Id = ProjectMembers.ProjectId INNER JOIN MobileSpaces on Project.MobileSpaceId = MobileSpaces.id WHERE ProjectMembers.ProjectMemberTypeId = {id}; ";
            return QueryExecutor.List<Project>(query);
        }
        public static bool Insert(Project project)
        {
            return project.Insert(TableConstants.Project) > 0;
        }
        public static bool Update(Project project)
        {
            return project.Update(TableConstants.Project, (int)project.Id) > 0;
        }
        public static bool Delete(long id)
        {
            return TableConstants.Project.Delete((int)id);
        }
    }
}
