namespace Generics.DataModels.Enums
{
    class TaskFilter
    {
    }
    public enum TaskTimeFilter
    {
        Overall,
        CurrentMonth,
        CurrentWeek,
        Today,
        Tomorrow
    }
    public enum TaskStatusFilter
    {
        All,
        Pending,
        Done
    }
    public enum ProjectFilter
    {
        All,
        Active,
        InActive,
        HaveDesigner,
        HaveScheduler,
        Alert
    }
}
