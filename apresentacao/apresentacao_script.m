fs=44100
Ts=1/44100
f=440;
delay=floor(fs/440)
%Wah effect
fc=2000;
F=2*sin((pi*fc)/fs);
Q=2*0.05;
%Fuzz - Usar Karplus-Strong Algorithm
%sound(note./max(note).*(1-exp(22*note.^2./max(note))),fs)

%Karplus +
beta=1/9; %pick position
N=2*fs/440;; %2*string lengh in samples
beta_disp=0.85;
n=(1-beta_disp*cos(pi*(1250)/fs))/(1-beta_disp);
rho=n-(n^2-1)^1/2;

%Produce Note
%sound_data=sim("apresentacao.slx",6)
%note=sound_data.simout.Data;
%note=squeeze(note);
    %Para audio file
    %%{
    sound_data=sim("apresentacao.slx",10)
    note=sound_data.simout.Data;
    note=squeeze(note);
    

   %%}
note=real(note);
note = note-mean(note);
note = note/max(abs(note));
sound(note,fs)
