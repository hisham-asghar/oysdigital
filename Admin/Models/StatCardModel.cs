namespace Admin.Models
{
    public class StatCardModel
    {
        public int Total { get; set; }
        public int Done { get; set; }
        public int Pending { get; set; }
        public double DonePercent { get; set; }
        public string Link { get; set; }
        public string Title { get; set; }
        public bool IsActive { get; set; }

    }
}
