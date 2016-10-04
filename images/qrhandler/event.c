// BAR CODE SCANNER: http://stackoverflow.com/a/29956584

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>
#include <dirent.h>
#include <linux/input.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/select.h>
#include <sys/time.h>
#include <termios.h>
#include <signal.h>

// #define DEBUG 1

// "linux kernel" "input subsystem"

static int fd = -1;

char* gettypename(unsigned short int type)
{
  static char *types[] = {
     "EV_SYN",
     "EV_KEY", // a keypress or release
     "EV_REL", // for relative movement ?
     "EV_ABS", // absolute new value for e.g. joysticks
     "EV_MSC","EV_SW",
     "EV_LED","EV_SND","EV_REP","EV_FF","EV_PWR", "EV_FF_STATUS", "EV_MAX" 
  };
   
  if (type < (sizeof(types) / sizeof(types[0])))
    return types[type];
   
  return "_ WRONG EV TYPE _";
}


char* getkey(signed int value)
{
  // Scancode conversion array 
  static char *keycodes[256] = 
  { "_reserved_", "<esc>", 
     "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", 
     "-", "=", "<backspace>", "<tab>", 
     "q", "w", "e", "r", "t", "y", 
     "u", "i", "o", "p", 
     "[", "]", 
     "\n", "<left-control>", 
     "a", "s", "d", "f", 
     "g", "h", 
     "j", "k", "l", 
     ";", "'", "<grave>", "<left-shift>", "\\",
     "z", "x", "c", "v", "b", "n", "m", 
     ",", ".", "/", 
     "<right-shift>", 
     "KP *", "<left-alt>", " ", "<capslock>", 
     "<f1>", "<f2>", "<f3>", "<f4>", "<f5>", "<f6>", "<f7>", "<f8>", "<f9>", "<f10>", 
     "<numlock>", "<scrolllock>", 
     "KP 7", "KP 8", "KP 9", 
     "KP -", 
     "KP 4", "KP 5", "KP 6",
     "KP +", 
     "KP 1", "KP 2", "KP 3", "KP 0", "KP .",
     "_?-?_",
     "<ZENKAKUHANKAKU>", "102ND",     
     "f11", "f12", 
     "<RO>", "<KATAKANA>", "<HIRAGANA>", "<HENKAN>", 
     "<KATAKANAHIRAGANA>", "<MUHENKAN>", "<KP JP ,>",
     "<KP ENTER>", "<right-control>", "<KP />", "<sysreq>",
     "<right-alt>", "<LINE FEED>", "<HOME>", "<UP>", "<PAGE UP>", "<LEFT>", "<RIGHT>", "<END>", "<DOWN>", "<PAGE DOWN>", 
     "<INS>", "<DEL>", "<MACRO>", "<MUTE>", "<VOL ->", "<VOL +>", "<POWER>", "<KP = >", "<KP +/- >", "<PAUSE>", "<SCALE>",
     "<KP ,>", "<HANGEUL>", "<HANJA>", "<YEN>", "<left-meta>", "<right-meta>", "<COMPOSE>", "<STOP>",
     "<AGAIN>", "<PROPS>", "<UNDO>", "<FRONT>", "<COPY>", "<OPEN>", "<PASTE>", "<FIND>",
     "<CUT>", "<HELP>", "<MENU>", "<CALC>", "<SETUP>", "<SLEEP>", "<WAKEUP>", "<FILE>",
     "<SEND FILE>", "<DELETE FILE>", "<XFER>", "<PROG 1>", "<PROG 2>", "<WWW>", "<MSDOS>", "<COFFEE>",
     "<ROTATE_DISPLAY>", "<CYCLE WINDOWS>", "<MAIL>", "<BOOKMARKS>", "<COMPUTER>", "<BACK>", "<FORWARD>", "<CLOSE CD>",
     "<EJECT CD>", "<EJECT CLOSE CD>", "<NEXT SONG>", "<PLAY PAUSE>", "<PREVIOUS SONG>", "<STOP CD>", 
     "<RECORD>", "<REWIND>",
     "<PHONE>", "<ISO>", "<CONFIG>", "<HOME PAGE>", "<REFRESH>", "<EXIT>", "<MOVE>", "<EDIT>",
     "<SCROLL UP>", "<SCROLL DOWN>", "<KP LEFT PAREN>", "<KP RIGHT PAREN>", "<NEW>", "<REDO>", "<f13>", "<f14>",
     "<f15>", "<f16>", "<f17>", "<f18>", "<f19>", "<f20>", "<f21>", "<f22>",
     "<f23>", "<f24>", // 194
     "_?-?_", // 195
     "_?-?_", // 196
     "_?-?_", // 197
     "_?-?_", // 198
     "_?-?_", // 199
     "<PLAY CD>", // 200
     "<PAUSE CD>", "<PROG 3>", "<PROG 4>", "<DASHBOARD>", "<SUSPEND>",
     "<CLOSE>", "<PLAY>", "<FAST FORWARD>", "<BASS BOOST>", "<PRINT>", "<HP>", "<CAMERA>", "<SOUND>",
     "<QUESTION>", "<EMAIL>", "<CHAT>", "<SEARCH>", "<CONNECT>", "<FINANCE>", "<SPORT>", "<SHOP>",
     "<ALTERASE>", "<CANCEL>", "<BRIGHTNESS ->", "<BRIGHTNESS +>", "<MEDIA>", "<SWITCH VIDEO MODE>", 
     "<KBDILLUM TOGGLE>", "<KBDILLUM DOWN>", "<KBDILLUM UP>", 
     "<SEND>", "<REPLY>", "<FORWARD MAIL>", "<SAVE>", "<DOCUMENTS>",     
     "<BATTERY>", "<BLUETOOTH>",
     "<WLAN>", "<UWB>", "<UNKNOWN>", "<VIDEO_NEXT>", "<VIDEO_PREV>", 
     "<BRIGHTNESS_CYCLE>", "<BRIGHTNESS_AUTO>", "<DISPLAY_OFF>",
     "<WWAN>","<RFKILL>", "<MIC MUTE>", // 248
     "_???_", // 249
     "_???_", // 250
     "_???_", // 251
     "_???_", // 252
     "_???_", // 253
     "_???_", // 254
     "_???_"  // 255
  }; 

  if (value < (sizeof(keycodes) / sizeof(keycodes[0])))
    return keycodes[value];
   
  return "_ WRONG?! _";
//  return keycodes[value & 0xff]; // 
}

void handler (int sig)
{
  int result;
  fprintf(stderr, "\nExiting due to signal: (%d)... \n", sig);
  
  if (fd != -1)
  {
    result = ioctl(fd, EVIOCGRAB, 0); 
    fprintf(stderr, "Giving away exclusive access: %s\n", (result == 0) ? "SUCCESS" : "FAILURE");
    close(fd); fd = -1;
  }

  fflush (stdout); 
  fflush (stderr); 
   
  exit (0);
}
 
void perror_exit (char *error)
{
  fprintf(stderr, "ERROR: \n%s\n", error);
  handler (9);
}
 
int main (int argc, char *argv[])
{
  struct input_event ev[64];
  int result = 0;
  int i = 25; 
  int rd, value;
  int size = sizeof (struct input_event);
  char name[256] = "Unknown";
  char *device =  "/dev/input/event3"; // 7?
 

  if (argc > 1)
   device = argv[1];
 
  //Setup check
  if (device == NULL){
      printf("Please specify (on the command line) the path to the dev event interface devicen");
      return 0;//      exit (0);
    }
 
  if ((getuid ()) != 0)
    fprintf(stderr, "You are not root! This may not work...n");
 
  //Open Device
  if ((fd = open (device, O_RDONLY)) == -1)
     {
       fprintf(stderr, "Failed to open event device '%s'.\n", device);
       return -1;        // exit(1);
     }
   
 
  //Print Device Name
  result = ioctl(fd, EVIOCGNAME(sizeof(name)), name);
  fprintf(stderr, "Reading From : %s (%s)\n", device, name);

  result = ioctl(fd, EVIOCGRAB, 1);

  fprintf(stderr, "Getting exclusive access: %s\n", (result == 0) ? "SUCCESS" : "FAILURE");
   
  while (i--) 
    signal (i, &handler); 
   
  while (1){
      memset((void*)&ev, 0, sizeof(ev));
     
      if ((rd = read (fd, ev, size * 64)) < size)
       {	  
	  if (rd == 0)
	    perror_exit ("Failed to read event: device detached?... ");
	  
	  if(rd == -1)
	    {
	       if (errno == EINTR)
		 continue;
	       
	       if (errno == EAGAIN) // sleep open with +|O_NONBLOCK
		 continue;
	    }

	  perror_exit ("Failed to read event... ");
	  break;
       }
     
  
//     if (ev[0].value == 1 && ev[0].type == EV_KEY) // Only read the key press event
//       printf ("Code[%d]\n", (ev[0].code));
     
     fprintf(stderr, "Reading %d: (%d / %d) events: \n", (rd / size), rd, size);
     
     for (i = 0; i < (rd/size); i++)
       fprintf(stderr, "(%15ld): type: '%s' (%1hx); code: 0x%4hx (%hu) =>?> [  '%s'  ]; value: 0x%4x (%d) =>?> [  '%s'  ]\n",
         (ev[i].time.tv_sec*1000000L + ev[i].time.tv_usec),  
         gettypename(ev[i].type), ev[i].type, 
         ev[i].code, ev[i].code, ((ev[i].type == EV_KEY)? getkey(ev[i].code) : ""),
         ev[i].value, ev[i].value, ((ev[i].type == EV_MSC)? getkey(ev[i].value) : "") );
     fprintf(stderr, "\n");
     
      // Only read the key press event 
      // NOT the key release event 
      value = ev[0].value; 
     
      if (/*value != ' ' &&*/ ev[0].type == EV_MSC && ev[1].type == EV_KEY && ev[2].type == EV_SYN && ev[1].code == value)
        { 
	   if ( ev[1].value == 1 )
	     {
               fprintf(stderr, "pressed: [  '%s'  ]\n", getkey(value) );
               fprintf(stdout, "%s", getkey(value) );  // TODO?: process shift, control, meta/alt, capslock?
	     }	   
	   else if ( ev[1].value == 0 )
           {
              fprintf(stderr, "release: [  '%s'  ]\n", getkey(value) );
//              fprintf(stdout, "%s", getkey(value) );
           }
	   else // ( ev[1].value == 0 )
              fprintf(stderr, "%4x =>?> [  '%s'  ]\n", ev[1].value, getkey(value) );
	   
	   fflush (stdout); 
        } 
     
  }
  // NOTE: never come here!?
   
  fprintf(stderr, "Exiting.\n");
  result = ioctl(fd, EVIOCGRAB, 0);
  fprintf(stderr, "Giving away exclusive access: %s\n", (result == 0) ? "SUCCESS" : "FAILURE");
   
  close(fd); fd = -1;

  fflush (stderr); 
  fflush (stdout); 
   
  return 0;
} 




