namespace ELearningAPI.Models
{
    public class Enrollment
    {
        public int Id { get; set; }
        public string StudentId { get; set; } = string.Empty;
        public int CourseId { get; set; }
        public DateTime EnrolledAt { get; set; } = DateTime.UtcNow;
        public DateTime? CompletedAt { get; set; }
        public string Status { get; set; } = "Active"; // Active, Completed, Dropped
        public double Progress { get; set; } = 0.0; // Percentage completed
        public double? Grade { get; set; }
        public string? CertificateUrl { get; set; }
        
        // Navigation properties
        public virtual ApplicationUser Student { get; set; } = null!;
        public virtual Course Course { get; set; } = null!;
        public virtual ICollection<LessonProgress> LessonProgress { get; set; } = new List<LessonProgress>();
    }
}
