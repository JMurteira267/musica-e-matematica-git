Fs=44100
Ts=1/Fs
f=110
f_fund=440
delay=round(Fs/f)
t_final=4
n=0
t_intervalo=linspace(0,t_final,Fs*t_final);
note=zeros(Fs*t_final,1);
note2=zeros(Fs*t_final,1);
fp=fopen("notes_add3/dicionario_bells_range_agudo.txt","w");
fprintf(fp,"Notation=KeyNumber\n")
note_names=["C","C#","D","D#","E","F","F#","G","G#","A","A#","B"]
n=[0.56 0.92 1.19 1.71 2 2.74 3 3.76 4.07]
volume=[0.06 0.2 0.5 1 3 6 8 10]*10^-1
%Nota kinda nice
for m=5:13
    for ex=0:11
        for k=1:(Fs*t_final)
            t=t_intervalo(k);
            f_fund=32.70*(2^m)*(2)^(ex/12);
            f=f_fund+0.01*cos(2*pi*20*f_fund);
            for count=1:9
                 if(t<0.003)
                    g=0.1/0.03*t;
                else
                    g=1.8^(-count/4*(t-0.03));
                end
                    note(k)=note(k)+g*cos(2*pi*n(count)*f*t)/(count/25);
            end 
            note(k)=g*note(k);      
        end
        note = note-mean(note);
        note = note/max(abs(note));
        
        s1=strcat(note_names(ex+1),num2str(m+1),"=",num2str((m-5)*12+ex));
        fprintf(fp,"%s\n",s1);
        if(strfind(s1,"#")>0)
                s2=strcat(note_names(ex+2),"b",num2str(m+1),"=",num2str((m-5)*12+ex));
                %s_write2=strcat("notes_add3/sons_addsynth_bells_",num2str(f_fund),"_",note_names(ex+2),"b",num2str(m+1),"_v",num2str(vol_counter),"_.wav");
                fprintf(fp,"%s\n",s2);
        end
            
        for vol_counter=1:8
            %s=strcat("notes_add3/sons_addsynth_bells_",num2str(f_fund),"_",note_names(ex+1),num2str(m+1),"_v",num2str(vol_counter),"_.wav");
            s=strcat("notes_add3/samples/sons_addsynth_bells_",note_names(ex+1),num2str(m+1),"_v",num2str(vol_counter),"_.wav");
            note_to_write=note*volume(vol_counter);
            audiowrite(s,note_to_write,Fs)
            if(strfind(s1,"#")>0)
                s_write2=strcat("notes_add3/samples/sons_addsynth_bells_",note_names(ex+2),"b",num2str(m+1),"_v",num2str(vol_counter),"_.wav");
                audiowrite(s_write2,note_to_write,Fs)
            end
            
            %sound(note_to_write,Fs)
            
        end
        note=zeros(Fs*t_final,1);
    end
end

fclose(fp)

