Fs=44000
Ts=1/Fs
n=0
ex=0
le_tf=tf([0.8995 0.1087],[1 0.0136],Ts,'Variable','z^-1')

for n=0:7
    for ex=0:11
        A=32.70*(2^n)*(2)^(ex/12)
        delay=round(Fs/A)
        %{
        b  = firls(42, [0 1/delay 2/delay 1], [0 0 1 1]);
        a  = [1 zeros(1, delay) -0.5 -0.5];
        x = zeros(Fs*4, 1);
        z=tf('z')
        S=1.5
        B=0.1 %[0,1]
        P=delay/Fs
        g_cte=exp(-6.91*P/S)
        g0=g_cte*(1+B)/2
        g1=g_cte*(1-B)/4
        %}
        data=sim('string_perhaps.slx',4)
        note=data.simout.Data
        %note=squeeze(data.simout.Data(1,1,:))
        %zi = rand(max(length(b),length(a))-1,1);
        %note = filter(b, a, x, zi);
        %note = note-mean(note);
        %note = note/max(abs(note))
        %sound(10000*squeeze(data.simout.Data(1,1,:)),44000)
        sound(note,Fs)
        s=strcat("THESOUND",num2str(A),".wav")
        audiowrite(s,note,Fs)
    end
end