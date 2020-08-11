function  color= findColor( x,a,b,CA,CB,dy1,dy2 )

%H sunarthsh findColor() stirizetai ston anadromiko tupo 
%color_(i)=color_(i-1)+(CB-CA)/(b-a).Dhladh to xrvma enos shmeiou mias
%grammhs prokuptei apo to proigoumeno xrwma pros8etontas ton oro
%(CB-CA)/(b-a),h arxikh timh einai color_(0)=CA. O parakatw  oros (x-a) 
%pou pollaplasiazei ton suntelesth (CB-CA)/(b-a) einai sthn ousia to "i" tou color_(i)

if a==b
    color=CA; %otan 3ekiname h teleiwnoume se korufh tou trigwnou kai CA=CB
else
    color=CA+((dy2*(dy1*x-a))/(dy1*b-dy2*a))*(CB-CA); 
end

%O tupos prokuptei apo ton antistoixo ths findcolor an antikatastisoume
%a=a/dy1 kai b=b/dy2 kai kanoume tis pra3eis,etsi den upologizoume tis
%pragmatikes suntetagmenes opws e3alou zhteitai sthn ekfwnish kai ginetai xrhsh
%mono twn metasxhmatismenwn suntetamnenwn.