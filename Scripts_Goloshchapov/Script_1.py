import RPi.GPIO as GPIO


def num2dac(value):
    a = bin(value)
    a = a.split('b')[1]
    a = "0"*(8 - len(a)) + a
    return list(map(int, a))


chan_list = [26, 19, 13, 6, 5, 11, 9, 10]

GPIO.setmode(GPIO.BCM)
GPIO.setup(chan_list, GPIO.OUT)


while True:
    n = input()
    try:
        n = int(n)
    except ValueError:
        GPIO.output(chan_list, [0]*8)
        GPIO.cleanup()
        break

    if n < 0:
        GPIO.output(chan_list, [0]*8)
        GPIO.cleanup()
        break
    else:
        n = num2dac(n)
        GPIO.output(chan_list, n)