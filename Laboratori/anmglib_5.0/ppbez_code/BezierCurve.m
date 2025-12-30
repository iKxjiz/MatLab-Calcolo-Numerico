classdef BezierCurve < handle
    %BEZIERCURVE Class for handling bezier curves
    properties (Constant)
        numberOfEvaluationPoints=100;
    end
    properties
        
        %initialize plots array to empty vectors
        controlPlots=[];
        controlBeziers=[];
        %initialize control points to empty vector
        controlPoints=[];
        %initialize control number
        controlNumber=0;
        %initialize control pieces to empty vector;
        controlPieces=[];
        %default curve is not closed
        closedCurve=0;
        %initialize curve's variables to empty vectors
        yDerivative=[];
        xDerivative=[];
        xValues=[];
        yValues=[];
    end
    
    methods
        function Save(this,counter,max)
            nc=sum(this.controlPieces);
            ncp=length(this.controlPieces);
            vind=find(this.controlPieces);
            filename='ppbez_design.db';
            fid=fopen(filename,'w');
            fprintf(fid,'FILENAME:%s\n',filename);
            if (length(this.controlBeziers)>1)
                fprintf(fid,'NC\n');
                fprintf(fid,'%i\n',nc);
            end
            g=vind(1)-1;
            fprintf(fid,'DEGREE\n');
            fprintf(fid,'%i\n',g);
            mdflag=0;
            i=1;
            while (i<nc && mdflag==0)
              i=i+1;
              if (g ~= vind(i)-vind(i-1))
                 mdflag=1;
              end
            end
            if (mdflag==1)
              for i=2:nc
                fprintf(fid,'%i\n',vind(i)-vind(i-1));
              end
            end
            fprintf(fid,'COORD.C.P.(X,Y)\n');
            for i=1:ncp
               fprintf(fid,'%e %e\n',this.controlPoints(1,i),this.controlPoints(2,i));
            end  
            if (length(this.controlBeziers)>1)
                fprintf(fid,'KNOTS\n');
            else
                fprintf(fid,'[a,b]\n');
            end
            for i=0:nc
              fprintf(fid,'%e\n',i);
            end
            status=fclose(fid);
        end
               
        function bezierCurve = calculateBezier(this,In,Fin)
            %create a vector of 100 equally spaced points between 0 and 1 
            linearSpace=linspace(0,1,this.numberOfEvaluationPoints);
            %calculate the vector of x positions of the curve
            [this.xValues(end+1,:), this.xDerivative(end+1,:)]=decastWithDerivative(this.controlPoints(1,In:Fin),linearSpace);
            %calculate the vector of y positions of the curve
            [this.yValues(end+1,:), this.yDerivative(end+1,:)]=decastWithDerivative(this.controlPoints(2,In:Fin),linearSpace);
            bezierCurve(1,:) = this.xValues(end,:);
            bezierCurve(2,:) = this.yValues(end,:);
        end
        
        function [pointX,pointY,xderivative,yderivative] = getDerivativeValue(this,x,y,counter)
            %find the neares point and get it derivative
            %create array of distance between the searched point and the
            %evaluated point
            distance = [(this.xValues(counter,:)-x)',(this.yValues(counter,:)-y)'];
            %calculate norm of each pair
            for i=1:length(distance)
                normalized(i) = norm (distance(i));
            end
            %fid the minimum value (least squares distance)
            [~,index] = min(normalized);
            %get coordinate value
            %return also this for draw precisely the tangent/normal
            pointX = this.xValues(counter,index);
            pointY = this.yValues(counter,index);
            %get derivative value
            xderivative = this.xDerivative(counter,index);
            yderivative = this.yDerivative(counter,index);
        end
        
        function tangent = getTangent(this,x,y,counter)
           %get derivative at the given points
           [x,y,derivative(1),derivative(2)] = this.getDerivativeValue(x,y,counter);
           %linear space between [-1,1] instead of [0,1] for drawing also a backward line
           linearSpace = linspace(-1,1,this.numberOfEvaluationPoints);
           %normalize vector
           derivative(1)=derivative(1)/norm(derivative);
           derivative(2)=derivative(2)/norm(derivative);
           %create line
           tangent(1,:) = x+derivative(1)*(linearSpace);
           tangent(2,:) = y+derivative(2)*(linearSpace);
        end
        
        function normal = getNormal(this,x,y,counter)
           %get derivative value at the given points
           [x,y,derivative(1),derivative(2)] = this.getDerivativeValue(x,y,counter);
           linearSpace = linspace(-1,1,this.numberOfEvaluationPoints);
           %determine ortogonal vector
           derivative(1)=-derivative(2)/derivative(1);
           derivative(2)=1;
           %normalize vector
           derivative = derivative./norm(derivative);
           %create line
           normal(1,:) = x+derivative(1)*(linearSpace);
           normal(2,:) = y+derivative(2)*(linearSpace);
        end
        
        function [value,TotalLength]=getLength(this,counter,max)
            %function to get the norm of the derivatives
            function val = funToIntegrate(this,x,para)
                %mapping index from [0,1] to [1,1000]
                index = round((x*(this.numberOfEvaluationPoints-1))+1);
                xderiv = this.xDerivative(para,index);
                yderiv = this.yDerivative(para,index);
                val = norm([xderiv,yderiv]);
            end
            
            TotalLength=0;
            for i=1:max
                %get left extreme function value
                fa = funToIntegrate(this,0,i);
                %get right extreme function value
                fb = funToIntegrate(this,1,i);
                %get not composite integral initial value
                trapez = trapezoid(0,1,fa,fb);
                v = trapezoid_adapt(@(x) funToIntegrate(this,x,i),0,1,fa,fb,0.001,trapez);
                TotalLength = TotalLength + v;
                if (i == counter)
                    value = v;
                end
            end
            
        end
        
    end
    
end

