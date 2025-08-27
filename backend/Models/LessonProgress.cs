namespace ELearningAPI.Models
{
    public class LessonProgress
    {
        public int Id { get; set; }
        public string StudentId { get; set; } = string.Empty;
        public int LessonId { get; set; }
        public int EnrollmentId { get; set; }
        public bool IsCompleted { get; set; } = false;
        public DateTime? CompletedAt { get; set; }
        public double WatchTime { get; set; } = 0.0; // in seconds
        public DateTime LastAccessed { get; set; } = DateTime.UtcNow;
        
        // Navigation properties
        public virtual ApplicationUser Student { get; set; } = null!;
        public virtual Lesson Lesson { get; set; } = null!;
        public virtual Enrollment Enrollment { get; set; } = null!;
    }
}
