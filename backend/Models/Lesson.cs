namespace ELearningAPI.Models
{
    public class Lesson
    {
        public int Id { get; set; }
        public string Title { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public string Content { get; set; } = string.Empty;
        public string? VideoUrl { get; set; }
        public int Duration { get; set; } // in minutes
        public int Order { get; set; }
        public int CourseId { get; set; }
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public DateTime? UpdatedAt { get; set; }
        public bool IsPublished { get; set; } = false;
        
        // Navigation properties
        public virtual Course Course { get; set; } = null!;
        public virtual ICollection<LessonProgress> Progress { get; set; } = new List<LessonProgress>();
    }
}
