package kz.student.studentapi;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class StudentRepositoryTest {

    @Autowired
    StudentRepository repository;

    @Test
    void savesAndUpdatesStudent() {
        Student student = new Student();
        student.setFullName("Serik Assylzhan");
        student.setEmail("serikasylzhan20051226@gmail.com");
        Student saved = repository.save(student);
        assertThat(saved.getId()).isNotNull();

        saved.setEmail("new.email@example.com");
        repository.save(saved);

        Student found = repository.findById(saved.getId()).orElseThrow();
        assertThat(found.getEmail()).isEqualTo("new.email@example.com");
    }
}
