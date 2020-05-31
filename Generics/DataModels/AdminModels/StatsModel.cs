namespace Generics.DataModels.AdminModels
{
    public class StatsModel
    {
        public int OverallTotal { get; set; }
        public int OverallDone { get; set; }
        public int OverallPending { get; set; }
        public double OverallDonePercent { get; set; }
        public int CurrentMonthTotal { get; set; }
        public int CurrentMonthDone { get; set; }
        public int CurrentMonthPending { get; set; }
        public double CurrentMonthDonePercent { get; set; }
        public int CurrentWeekTotal { get; set; }
        public int CurrentWeekDone { get; set; }
        public int CurrentWeekPending { get; set; }
        public double CurrentWeekDonePercent { get; set; }
        public int TodayTotal { get; set; }
        public int TodayDone { get; set; }
        public int TodayPending { get; set; }
        public double TodayDonePercent { get; set; }


        public int TomorrowTotal { get; set; }
        public int TomorrowDone { get; set; }
        public int TomorrowPending { get; set; }
        public double TomorrowDonePercent { get; set; }
    }
}
