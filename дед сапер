import pygame
import random


class Board:
    def __init__(self, width, height):
        self.width = width
        self.height = height
        self.board = [[0] * width for _ in range(height)]
        self.left = 10
        self.top = 10
        self.cell_size = 30

    def set_view(self, left, top, cell_size):
        self.left = left
        self.top = top
        self.cell_size = cell_size

    def render(self, screen):
        color = pygame.Color('white')
        for y in range(self.height):
            for x in range(self.width):
                coor = (x * self.cell_size + self.left, y * self.cell_size + self.top, self.cell_size, self.cell_size)
                pygame.draw.rect(screen, color, coor, 1)

    def get_cell(self, mouse_pos):
        cell_x = (mouse_pos[0] - self.left) // self.cell_size
        cell_y = (mouse_pos[1] - self.top) // self.cell_size
        if cell_x < 0 or cell_x >= self.width or cell_y < 0 or cell_y >= self.height:
            return None
        return cell_x, cell_y

    def on_click(self, cell):
        pass

    def get_click(self, mouse_pos):
        cell = self.get_cell(mouse_pos)
        if cell:
            self.on_click(cell)


class Dedushka(Board):
    def __init__(self, width, height, need):
        super().__init__(width, height)
        self.board = [[-1] * width for inet in range(height)]
        ter = 0
        while ter < need:
            x = random.randint(0, self.width - 1)
            y = random.randint(0, self.height - 1)
            if self.board[y][x] == -1:
                self.board[y][x] = 10
                ter += 1

    def open_click(self, cell):
        x, y = cell
        if self.board == 10:
            return
        s = 0
        for dy in range(-1, 2):
            for dx in range(-1, 2):
                if x + dx < 0 or x + dx >= self.width or y + dy < 0 or y + dy >= self.height:
                    continue
                if self.board[y + dy][x + dx] == 10:
                    s += 1
        self.board[y][x] = s

    def on_click(self, cell):
        self.open_click(cell)

    def render(self, screen):
        color = pygame.Color('red')
        for y in range(self.height):
            for x in range(self.width):
                coor = (x * self.cell_size + self.left, y * self.cell_size + self.top,
                        self.cell_size, self.cell_size)
                coor1 = (x * self.cell_size + self.left + 2, y * self.cell_size + self.top + 2,
                         self.cell_size, self.cell_size)
                if self.board[y][x] == 10:
                    pygame.draw.rect(screen, color, coor)
                pygame.draw.rect(screen, pygame.Color('white'), coor, 1)
                if self.board[y][x] >= 0 and self.board[y][x] != 10:
                    font = pygame.font.Font(None, self.cell_size - 7)
                    text = font.render(str(self.board[y][x]), 1, (100, 255, 100))
                    screen.blit(text, coor1)


def main():
    pygame.init()
    size = 500, 500
    screen = pygame.display.set_mode(size)
    pygame.display.set_caption('Дедушка сапёра')
    clock = pygame.time.Clock()
    board = Dedushka(10, 15, 10)
    ticks = 0
    running = True
    while running:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False
            if event.type == pygame.MOUSEBUTTONDOWN:
                board.get_click(event.pos)
        screen.fill((0, 0, 0))
        board.render(screen)
        pygame.display.flip()
        clock.tick(50)
        ticks += 1
    pygame.quit()


if __name__ == '__main__':
    main()
