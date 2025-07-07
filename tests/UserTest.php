<?php
namespace Tests;

use PHPUnit\Framework\TestCase;
use App\Database;
use App\User;

class UserTest extends TestCase {
    private $conn;
    private $user;

    protected function setUp(): void {
        $this->conn = (new Database())->getConnection();
        $this->conn->exec("CREATE TABLE IF NOT EXISTS users (
            id INT AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(255),
            email VARCHAR(255)
        )");
        $this->user = new User($this->conn);
    }

    public function testCreateAndReadUser() {
        $this->user->create("Test", "test@example.com");
        $users = $this->user->read();
        $this->assertNotEmpty($users);
    }

    public function testUpdateUser() {
        $this->user->create("Temp", "temp@example.com");
        $this->assertTrue($this->user->update(1, "Updated", "updated@example.com"));
    }

    public function testDeleteUser() {
        $this->user->create("ToDelete", "delete@example.com");
        $this->assertTrue($this->user->delete(1));
    }
}
