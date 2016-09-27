#pragma once

#define MOVE (0.01f)
#define ROT (M_PI / 1024.0f)
#define CAMERA (-1)

struct s_key_callback
{
  SDLKey key;
  void (*callback)(s_data *data);
};

extern s_key_callback g_key_callback_tab[];

int key_listener(s_data *data);

void key_forward(s_data *data);
void key_backward(s_data *data);
void key_left(s_data *data);
void key_right(s_data *data);
void key_up(s_data *data);
void key_down(s_data *data);
void key_left_rotate(s_data *data);
void key_right_rotate(s_data *data);
void key_up_rotate(s_data *data);
void key_down_rotate(s_data *data);
