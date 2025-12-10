function ValoreAttr = SearchAttrDom(child, attr, defaultValue)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cerca l'attributo indicato andando in su sul DOM. 
% Si ferma al primo padre che ha questo attributo.
% Ovviamente se l'attributo è già presente su "child", viene restituito
% quest'ultimo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% child: il figlio su qualle cercare
% attr: l'attributo da cercare
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x = child;
while (numel(x) > 0 && x.hasAttributes && x.hasAttribute(attr) == false)        
    x = x.getParentNode;
end
if numel(x) > 0 && x.hasAttributes
    ValoreAttr = x.getAttribute(attr);
else
    ValoreAttr = defaultValue;
end

end

