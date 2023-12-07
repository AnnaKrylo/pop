import pygame

if name == 'main':
    pygame.init()
    pygame.display.set_caption('Перетаскивание')
    size = width, height = 300, 300
    screen = pygame.display.set_mode(size)

    running, moving = True, False
    x, y = 0, 0
    x_old, y_old, x_new, y_new = 0, 0, 0, 0
    while running:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False
            if event.type == pygame.MOUSEBUTTONDOWN and event.button == 1:
                if x < event.pos[0] < x + 100 and y < event.pos[1] < y + 100:
                    moving = True
            if event.type == pygame.MOUSEMOTION:
                if moving:
                    x_new, y_new = event.rel
                    x, y = x + x_new, y + y_new
            if event.type == pygame.MOUSEBUTTONUP and event.button == 1:
                moving = False

        pygame.draw.rect(screen, (0, 255, 0), (x, y, 100, 100))

        pygame.display.flip()
        screen.fill((0, 0, 0))
    pygame.quit()
