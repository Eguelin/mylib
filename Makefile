# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: eguelin <eguelin@student.42lyon.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/01/17 15:15:24 by eguelin           #+#    #+#              #
#    Updated: 2024/01/17 15:02:34 by eguelin          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

.PHONY: all clean fclean re
.SILENT:

# **************************************************************************** #
#                                   Variable                                   #
# **************************************************************************** #

NAME	= mylib.a
OBJ_DIR	= .obj/
SRC_DIR	= src/
INC_DIR	= include/
CC		= cc
CFLAGS	= -Wall -Werror -Wextra
INC		= -I $(INC_DIR)
RM		= rm -fr
ARC		= ar -rcs

# **************************************************************************** #
#                                    Colors                                    #
# **************************************************************************** #

BLACK	= \033[30m
RED		= \033[31m
GREEN	= \033[32m
YELLOW	= \033[33m
BLUE	= \033[34m
PURPLE	= \033[35m
CYAN	= \033[36m
WHITE	= \033[37m
DEFAULT	= \033[0m

# **************************************************************************** #
#                                    Message                                   #
# **************************************************************************** #

COMP_MSG		= "$(GREEN)Compilation $(NAME) $(DEFAULT)done on $(YELLOW)$(shell date +'%Y-%m-%d %H:%M:%S')$(DEFAULT)"
CLEAN_MSG		= "$(RED)Cleaning $(NAME) $(DEFAULT)done on $(YELLOW)$(shell date +'%Y-%m-%d %H:%M:%S')$(DEFAULT)"
FULL_CLEAN_MSG	= "$(PURPLE)Full cleaning $(NAME) $(DEFAULT)done on $(YELLOW)$(shell date +'%Y-%m-%d %H:%M:%S')$(DEFAULT)"

# **************************************************************************** #
#                                    Sources                                   #
# **************************************************************************** #

DLST_DIR	= dlst/
DLST_FILES	= ft_dlstadd_back.c \
			  ft_dlstadd_front.c \
			  ft_dlstclear.c \
			  ft_dlstdelone.c \
			  ft_dlstfirst.c \
			  ft_dlstlast.c \
			  ft_dlstnew.c \
			  ft_dlstsize.c

ALL_FILES	= $(addprefix $(DLST_DIR), $(DLST_FILES))

GET_DIR		= get/
GET_FILES	= get_next_line.c

ALL_FILES	+= $(addprefix $(GET_DIR), $(GET_FILES))

IS_DIR		= is/
IS_FILES	= ft_isalnum.c \
			  ft_isalpha.c \
			  ft_isascii.c \
			  ft_isdigit.c \
			  ft_isprint.c

ALL_FILES	+= $(addprefix $(IS_DIR), $(IS_FILES))

LST_DIR		= lst/
LST_FILES	= ft_lstadd_back.c \
			  ft_lstadd_front.c \
			  ft_lstclear.c \
			  ft_lstdelone.c \
			  ft_lstiter.c \
			  ft_lstlast.c \
			  ft_lstmap.c \
			  ft_lstnew.c \
			  ft_lstsize.c

ALL_FILES	+= $(addprefix $(LST_DIR), $(LST_FILES))

MEM_DIR		= mem/
MEM_FILES	= ft_memchr.c \
			  ft_memcmp.c \
			  ft_memcpy.c \
			  ft_memmove.c \
			  ft_memset.c

ALL_FILES	+= $(addprefix $(MEM_DIR), $(MEM_FILES))

OTHER_DIR	= other/
OTHER_FILES	= ft_atoi.c \
			  ft_bzero.c \
			  ft_calloc.c \
			  ft_free_split.c \
			  ft_itoa.c \
			  ft_split.c \
			  ft_tolower.c \
			  ft_toupper.c

ALL_FILES += $(addprefix $(OTHER_DIR), $(OTHER_FILES))

PRINT_DIR	= print/
PRINT_FILES	= ft_print_address.c \
			  ft_print_all.c \
			  ft_print_base.c \
			  ft_print_char.c \
			  ft_printf.c \
			  ft_print_nbr.c \
			  ft_print_str.c

ALL_FILES	+= $(addprefix $(PRINT_DIR), $(PRINT_FILES))

PUT_DIR		= put/
PUT_FILES	= ft_putchar_fd.c \
			  ft_putendl_fd.c \
			  ft_putnbr_fd.c \
			  ft_putstr_fd.c

ALL_FILES	+= $(addprefix $(PUT_DIR), $(PUT_FILES))

STR_DIR		= str/
STR_FILES	= ft_strchr.c \
			  ft_strdup.c \
			  ft_striteri.c \
			  ft_strjoin_tab.c \
			  ft_strjoin_three.c \
			  ft_strjoin.c \
			  ft_strlcat.c \
			  ft_strlcpy.c \
			  ft_strlen.c \
			  ft_strmapi.c \
			  ft_strncmp.c \
			  ft_strnstr.c \
			  ft_strrchr.c \
			  ft_strtrim.c \
			  ft_substr.c

ALL_FILES	+= $(addprefix $(STR_DIR), $(STR_FILES))

OBJ_FILES	= $(addprefix $(OBJ_DIR), $(ALL_FILES:.c=.o))

DEP_FILES	= $(OBJ_FILES:.o=.d)

ALL_OBJ_DIR	= $(sort $(dir $(OBJ_FILES)))

# **************************************************************************** #
#                                     Rules                                    #
# **************************************************************************** #

all: $(NAME)

$(NAME): $(OBJ_FILES)
	$(ARC) $(NAME) $(OBJ_FILES)
	echo $(COMP_MSG)
	norminette | awk '$$NF!="OK!" {print "$(RED)" $$0 "$(WHITE)"}'

$(OBJ_DIR)%.o : $(SRC_DIR)%.c | $(ALL_OBJ_DIR)
	$(CC) $(CFLAGS) $(INC) -MMD -c $< -o $@

clean:
	$(RM) $(OBJ_DIR)
	echo $(CLEAN_MSG)

fclean: clean
	$(RM) $(NAME)
	echo $(FULL_CLEAN_MSG)

re: fclean all

$(ALL_OBJ_DIR):
	mkdir -p $@

-include $(DEP_FILES)
