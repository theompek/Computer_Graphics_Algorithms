function  color= findColor( x,a,b,CA,CB )

%H sunarthsh findColor() stirizetai ston anadromiko tupo 
%color_(i+1)=color_(i)+(CB-CA)/(b-a).Dhladh to xrvma enos shmeiou mias
%grammhs prokuptei apo to proigoumeno xrwma pros8etontas ton oro
%(CB-CA)/(b-a),h arxikh timh einai color_(0)=CA. O parakatw  oros (x-a) 
%pou pollaplasiazei ton suntelesth (CB-CA)/(b-a) einai sthn ousia to "i" tou color_(i)

if a==b
    color=CA; %otan 3ekiname h teleiwnoume se korufh tou trigwnou kai CA=CB
else
    color=CA+((x-a)/(b-a))*(CB-CA); 
end
