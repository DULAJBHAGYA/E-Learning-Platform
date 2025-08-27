using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ELearningAPI.Data;
using ELearningAPI.Models;
using ELearningAPI.DTOs;

namespace ELearningAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CoursesController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly UserManager<ApplicationUser> _userManager;

        public CoursesController(ApplicationDbContext context, UserManager<ApplicationUser> userManager)
        {
            _context = context;
            _userManager = userManager;
        }

        [HttpGet]
        public async Task<IActionResult> GetCourses([FromQuery] string? category, [FromQuery] string? level, [FromQuery] bool? isPublished)
        {
            var query = _context.Courses
                .Include(c => c.Instructor)
                .AsQueryable();

            if (!string.IsNullOrEmpty(category))
                query = query.Where(c => c.Category == category);

            if (!string.IsNullOrEmpty(level))
                query = query.Where(c => c.Level == level);

            if (isPublished.HasValue)
                query = query.Where(c => c.IsPublished == isPublished.Value);

            var courses = await query
                .Select(c => new
                {
                    c.Id,
                    c.Title,
                    c.Description,
                    c.Thumbnail,
                    c.Price,
                    c.Category,
                    c.Level,
                    c.Duration,
                    c.Rating,
                    c.TotalStudents,
                    c.TotalLessons,
                    c.IsPublished,
                    c.IsFeatured,
                    instructor = new
                    {
                        c.Instructor.FirstName,
                        c.Instructor.LastName,
                        c.Instructor.ProfilePicture
                    }
                })
                .ToListAsync();

            return Ok(courses);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetCourse(int id)
        {
            var course = await _context.Courses
                .Include(c => c.Instructor)
                .Include(c => c.Lessons)
                .Include(c => c.Materials)
                .FirstOrDefaultAsync(c => c.Id == id);

            if (course == null)
                return NotFound();

            var result = new
            {
                course.Id,
                course.Title,
                course.Description,
                course.Thumbnail,
                course.Price,
                course.Category,
                course.Level,
                course.Duration,
                course.Rating,
                course.TotalStudents,
                course.TotalLessons,
                course.IsPublished,
                course.IsFeatured,
                instructor = new
                {
                    course.Instructor.FirstName,
                    course.Instructor.LastName,
                    course.Instructor.ProfilePicture
                },
                lessons = course.Lessons.Select(l => new
                {
                    l.Id,
                    l.Title,
                    l.Description,
                    l.Duration,
                    l.Order,
                    l.IsPublished
                }).OrderBy(l => l.Order),
                materials = course.Materials.Select(m => new
                {
                    m.Id,
                    m.Title,
                    m.Description,
                    m.FileUrl,
                    m.FileType,
                    m.Order
                }).OrderBy(m => m.Order)
            };

            return Ok(result);
        }

        [HttpPost]
        [Authorize]
        public async Task<IActionResult> CreateCourse([FromBody] CreateCourseDto model)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            var userId = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;
            if (string.IsNullOrEmpty(userId))
                return Unauthorized();

            var course = new Course
            {
                Title = model.Title,
                Description = model.Description,
                Thumbnail = model.Thumbnail,
                Price = model.Price,
                Category = model.Category,
                Level = model.Level,
                Duration = model.Duration,
                InstructorId = userId
            };

            _context.Courses.Add(course);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetCourse), new { id = course.Id }, course);
        }

        [HttpPut("{id}")]
        [Authorize]
        public async Task<IActionResult> UpdateCourse(int id, [FromBody] UpdateCourseDto model)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            var course = await _context.Courses.FindAsync(id);
            if (course == null)
                return NotFound();

            var userId = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;
            if (course.InstructorId != userId)
                return Forbid();

            course.Title = model.Title ?? course.Title;
            course.Description = model.Description ?? course.Description;
            course.Thumbnail = model.Thumbnail ?? course.Thumbnail;
            course.Price = model.Price ?? course.Price;
            course.Category = model.Category ?? course.Category;
            course.Level = model.Level ?? course.Level;
            course.Duration = model.Duration ?? course.Duration;
            course.UpdatedAt = DateTime.UtcNow;

            await _context.SaveChangesAsync();

            return Ok(course);
        }

        [HttpDelete("{id}")]
        [Authorize]
        public async Task<IActionResult> DeleteCourse(int id)
        {
            var course = await _context.Courses.FindAsync(id);
            if (course == null)
                return NotFound();

            var userId = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;
            if (course.InstructorId != userId)
                return Forbid();

            _context.Courses.Remove(course);
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
